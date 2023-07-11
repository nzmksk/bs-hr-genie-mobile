// ignore_for_file: file_names

import 'dart:convert';
import 'package:hr_genie/Model/EmployeeModel.dart';
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

  Future<http.Response> saveUserData() async {
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
    return response;
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
    final jsonData = jsonDecode(response.body)['data'];
    List<LeaveQuota> quotaList = [];
    for (var item in jsonData) {
      LeaveQuota leaveQuota = LeaveQuota.fromJson(item);
      quotaList.add(leaveQuota);
    }
    print("Updated Leave Quota: ${response.body}");
    return response;
  }
}
