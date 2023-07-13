// ignore_for_file: file_names

import 'dart:convert';
import 'package:hr_genie/Constants/PrintColor.dart';
import 'package:hr_genie/Controller/Services/CachedStation.dart';
import 'package:hr_genie/Model/EmployeeModel.dart';
import 'package:hr_genie/Model/ErrorModel.dart';
import 'package:hr_genie/Model/LeaveQuotaModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  String baseUrl = 'http://192.168.18.30:2000';
  // String? accessToken;
  Future<http.Response> postLogin({
    required email,
    required password,
  }) async {
    http.Response response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
    return response;
  }

  Future<http.Response> postLogout(String accessToken) async {
    http.Response response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": accessToken,
      },
    );
    return response;
  }

  Future<Employee> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Saving Data and token in sharedPreferences
    String? accessToken = prefs.getString("access_token");
    String userDataRes = prefs.getString('user_data')!;

    final jsonData = json.decode(userDataRes);
    final Map<String, dynamic> data = jsonData['data'];
    final employee = Employee.fromJson(data);
    String id = employee.employeeId!;
    print("User ID: $id");
    //Calling to get the User Data
    http.Response response = await http.get(
      Uri.parse('$baseUrl/employees/$id'),
      headers: {
        "Content-Type": "application/json",
        "Bearer": "$accessToken",
      },
    );

    return employee;
  }

// TODO: Make this function dynamic instead of static
  Future<http.StreamedResponse?> refreshToken(
      {required http.Request originalRequest}) async {
    final refreshToken = await CacheStore().getCache('refresh_token');

    if (refreshToken != null) {
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Cookie": refreshToken,
      };

      http.Response response = await http.post(
        Uri.parse('$baseUrl/refresh_token'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        //SUCCESS
        final rawCookie = response.headers['set-cookie'];
        final jsonData = jsonDecode(response.body)['token'];
        final String newToken = jsonData;

        if (rawCookie != null) {
          await CacheStore().setCache('refresh_token', rawCookie);
        }
        await CacheStore().setCache('access_token', newToken);

        // TODO: Call the original request
        http.StreamedResponse newResponse =
            await http.Client().send(originalRequest);
        printGreen("Refreshed Token");
        return newResponse;
      } else {
        //UNAUTHORIZED
        // TODO: Clear all cache and redirect user to login page
        printRed("Unsuccessful: ${response.statusCode}");
        return null;
      }
    }
    printRed('refresh token is not found');
    return null;
  }

  void callLeaveQuota(http.Response response) {
    final jsonData = jsonDecode(response.body)['data'];
    List<LeaveQuota> quotaList = [];
    for (var item in jsonData) {
      LeaveQuota leaveQuota = LeaveQuota.fromJson(item);
      quotaList.add(leaveQuota);
    }
    printGreen(
        "Leave Quota successfully fetched: ${quotaList[0].leaveType} = ${quotaList[0].quota}");
  }

  Future<http.Response> fetchLeaveQuota(String accessToken) async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    };
    http.Response response = await http.get(
      Uri.parse('$baseUrl/leave_quota'),
      headers: headers,
    );
    return response;
  }

  Future<http.StreamedResponse> httpRequest(
      {required String method,
      required String endpoint,
      String? accessToken,
      Map<String, dynamic>? requestBody}) async {
    // TODO: change this address to env
    String baseUrl = 'http://192.168.18.30:2000';

    Map<String, String> requestHeader = {
      "Content-Type": "application/json",
      "Authorization": accessToken ?? "",
    };

    http.Request request = http.Request(method, Uri.parse('$baseUrl$endpoint'));
    request.headers.addAll(requestHeader);

    if (requestBody != null) {
      request.body = jsonEncode(requestBody);
    }

    http.StreamedResponse response = await http.Client().send(request);

    String jsonBody = await response.stream.bytesToString();
    Map<String, dynamic> responseBody = jsonDecode(jsonBody);
    if (response.statusCode == 400 &&
        responseBody['error'] ==
            'Access token expired. Please refresh your token.') {
      // TODO: call refresh_token endpoint
      http.StreamedResponse? refreshResponse =
          await refreshToken(originalRequest: request);
      if (refreshResponse != null) {}
    }
    return response;
  }
}
