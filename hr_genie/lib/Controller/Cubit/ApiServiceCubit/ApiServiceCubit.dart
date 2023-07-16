import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hr_genie/Constants/PrintColor.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/AprServiceState.dart';
import 'package:hr_genie/Controller/Services/CachedStation.dart';
import 'package:hr_genie/Controller/Services/CallApi.dart';
import 'package:hr_genie/Model/EmployeeModel.dart';
import 'package:hr_genie/Model/ErrorModel.dart';
import 'package:hr_genie/Model/LeaveModel.dart';
import 'package:hr_genie/Model/LeaveQuotaModel.dart';
import 'package:http/http.dart' as http;

class ApiServiceCubit extends Cubit<ApiServiceState> {
  ApiServiceCubit() : super(ApiServiceState.initial());
  // final String localhost = "172.20.10.12";
  // Future<List<Department>> fetchDepartments() async {
  //   final response =
  //       await http.get(Uri.parse('http://$localhost:2000/departments'));

  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     final List<dynamic> departmentData = jsonData['data'];
  //     final departments =
  //         departmentData.map((json) => Department.fromJson(json)).toList();
  //     return [...departments];
  //   } else {
  //     throw Exception('Failed to fetch departments');
  //   }
  // }

  // Future<void> addDepartment(Department department) async {
  //   final url = Uri.parse('http://$localhost:2000/departments/create');
  //   final jsonData = department.toJson();
  //   http.Response response = await http.post(
  //     url,
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode(jsonData),
  //   );
  //   if (response.statusCode == 200) {
  //   } else {}
  // }

  // Future<List<Employee>> fetchEmployees() async {
  //   final response =
  //       await http.get(Uri.parse('http://$localhost:2000/employees'));

  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     final List<dynamic> departmentData = jsonData['data'];
  //     final employees =
  //         departmentData.map((json) => Employee.fromJson(json)).toList();
  //     return employees;
  //   } else {
  //     throw Exception('Failed to fetch departments');
  //   }
  // }

  // Future<void> addEmployee(Employee employee) async {
  //   final url = Uri.parse('http://$localhost:2000/register');
  //   final jsonData = employee.toJson();
  //   http.Response response = await http.post(
  //     url,
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode(jsonData),
  //   );
  //   if (response.statusCode == 200) {
  //   } else {}
  // }

  Future<void> getLeaveQuota(String accessToken) async {
    http.Response response = await CallApi().fetchLeaveQuota(accessToken);

    if (response.statusCode == 200) {
      callLeaveQuota(response);
    } else if (response.statusCode == 400) {
      final jsonData = jsonDecode(response.body);
      final Map<String, dynamic> data = jsonData;
      final error = ErrorModel.fromJson(data);

      printRed("fetchLeaveQuota > ERROR: ${error.errorMsg}");

      if (error.errorMsg ==
          "Access token expired. Please refresh your token.") {
        final refreshToken = await CacheStore().getCache('refresh_token');
        //TODO: refresh token need to work on here
        // http.Response response = await CallApi().refreshToken(refreshToken!);
        print(response);
        if (response.statusCode == 200) {
          //SUCCESS
          final jsonData = jsonDecode(response.body)['token'];
          final String? newToken = jsonData;
          http.Response newResponse =
              await CallApi().fetchLeaveQuota(newToken!);
          callLeaveQuota(newResponse);
          printGreen("Refreshed Token");
        } else if (response.statusCode == 401) {
          //UNAUTHORIZED
          printRed("Unsuccessful: ${response.statusCode}");
        } else if (response.statusCode == 403) {
          //FORBIDDEN
          printRed("Unsuccessful: ${response.statusCode}");
        } else if (response.statusCode == 404) {
          //NOT FOUND
          printRed("Unsuccessful: ${response.statusCode}");
        }
      }
    }

    final jsonData = json.decode(response.body);
    final List<dynamic> data = jsonData['data'];
    List<LeaveQuota> leaveQuotaList = [];
    for (var item in data) {
      LeaveQuota leaveQuota = LeaveQuota.fromJson(item);
      leaveQuotaList.add(leaveQuota);
    }
    emit(state.copyWith(leaveQuotaList: leaveQuotaList));
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

  Future<void> getMyLeaves(String accessToken) async {
    http.Response response = await CallApi().fetchHistoryLeaves();

    final jsonData = jsonDecode(response.body)['data'];
    List<Leave> leaveList = [];
    for (var item in jsonData) {
      Leave leave = Leave.fromJson(item);
      leaveList.add(leave);
    }
    emit(state.copyWith(myLeaveList: leaveList));
  }

  Future<void> getRequestLeaves(
      String accessToken, String? departmentId) async {
    try {
      emit(state.copyWith(status: ApiServiceStatus.loading));
      http.Response response = await CallApi().fetchRequestLeaves(departmentId);
      final jsonData = jsonDecode(response.body)['data'];
      List<Leave> pendingList = [];
      List<Leave> approvedList = [];
      List<Leave> rejectedList = [];
      List<Leave> allList = [];

      if (response.statusCode == 200) {
        for (var item in jsonData) {
          Leave request = Leave.fromJson(item);
          print("Request Duration type: ${request.durationType}");
          allList.add(request);
        }
        pendingList = allList
            .where(
              (element) => element.applicationStatus == 'pending',
            )
            .toList();
        approvedList = allList
            .where(
              (element) => element.applicationStatus == 'approved',
            )
            .toList();
        rejectedList = allList
            .where(
              (element) => element.applicationStatus == 'rejected',
            )
            .toList();

        emit(state.copyWith(
            status: ApiServiceStatus.success,
            allRequestList: allList,
            pendingList: pendingList,
            approvedList: approvedList,
            rejectedList: rejectedList));
        emit(state.copyWith(status: ApiServiceStatus.initial));
      } else {
        final jsonData = jsonDecode(response.body);
        final Map<String, dynamic> data = jsonData;
        final error = ErrorModel.fromJson(data);
        emit(state.copyWith(
            status: ApiServiceStatus.success,
            allRequestList: null,
            pendingList: null,
            approvedList: null,
            rejectedList: null,
            errorMsg: error.errorMsg));
        emit(state.copyWith(status: ApiServiceStatus.initial));
      }
    } catch (e) {
      emit(state.copyWith(
          errorMsg: 'please connect to your server',
          status: ApiServiceStatus.failed));
    }
  }

  Future<void> sendApproval(Leave leaveModel) async {
    emit(state.copyWith(status: ApiServiceStatus.loading));
    final accessToken = await CacheStore().getCache('access_token');

    final userDataRes = await CacheStore().getCache('user_data');
    final jsonData = jsonDecode(userDataRes!);
    final departmentId = Employee.fromJson(jsonData).departmentId;
    getRequestLeaves(accessToken!, departmentId);
    try {
      http.Response response = await CallApi().patchRequest(leaveModel);
      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        final message = jsonData['message'];
        emit(state.copyWith(
            putRequestMsg: message, status: ApiServiceStatus.success));
        printGreen(message);
        emit(state.copyWith(status: ApiServiceStatus.initial));
      } else {
        final jsonData = jsonDecode(response.body);
        final message = jsonData['message'];
        printRed(message);
        emit(state.copyWith(
            putRequestMsg: message, status: ApiServiceStatus.success));
        emit(state.copyWith(status: ApiServiceStatus.initial));
      }
    } catch (e) {
      print('Error SendApproval: $e');
    }
  }
}
