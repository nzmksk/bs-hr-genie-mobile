import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hr_genie/Components/CustomSnackBar.dart';
import 'package:hr_genie/Constants/PrintColor.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/AprServiceState.dart';
import 'package:hr_genie/Controller/Services/CallApi.dart';
import 'package:hr_genie/Model/ErrorModel.dart';
import 'package:hr_genie/Model/LeaveModel.dart';
import 'package:hr_genie/Model/LeaveQuotaModel.dart';
import 'package:http/http.dart' as http;

class ApiServiceCubit extends Cubit<ApiServiceState> {
  ApiServiceCubit() : super(ApiServiceState.initial());

  Future<void> getLeaveQuota(String accessToken) async {
    emit(state.copyWith(status: ApiServiceStatus.loading));
    http.Response response = await CallApi().fetchLeaveQuota(accessToken);

    if (response.statusCode == 200) {
      callLeaveQuota(response);
      emit(state.copyWith(status: ApiServiceStatus.success));
      emit(state.copyWith(status: ApiServiceStatus.initial));
    } else if (response.statusCode == 400) {
      ErrorModel error = errorDecode(response);
      printRed("fetchLeaveQuota > ERROR: ${error.errorMsg}");
      emit(state.copyWith(
        status: ApiServiceStatus.failed,
        errorMsg: error.errorMsg,
      ));
      emit(state.copyWith(status: ApiServiceStatus.initial));
    } else {
      ErrorModel error = errorDecode(response);
      printRed(
          "fetchLeaveQuota > ERROR:${response.statusCode} ${error.errorMsg}");
      emit(state.copyWith(
          status: ApiServiceStatus.failed, errorMsg: error.errorMsg));
      emit(state.copyWith(status: ApiServiceStatus.initial));
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

  ErrorModel errorDecode(http.Response response) {
    final jsonData = jsonDecode(response.body);
    final Map<String, dynamic> data = jsonData;
    final error = ErrorModel.fromJson(data);
    return error;
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

    if (response.statusCode == 200) {
      for (var item in jsonData) {
        Leave leave = Leave.fromJson(item);
        leaveList.add(leave);
      }
      emit(state.copyWith(myLeaveList: leaveList));
    } else if (response.statusCode == 404) {
      emit(state.copyWith(myLeaveList: leaveList));
    }
  }

  Future<void> getRequestLeaves(
      String accessToken, String? departmentId) async {
    emit(state.copyWith(status: ApiServiceStatus.loading));
    try {
      http.Response response = await CallApi().fetchRequestLeaves(departmentId);
      final jsonData = jsonDecode(response.body)['data'];
      List<Leave> pendingList = [];
      List<Leave> approvedList = [];
      List<Leave> rejectedList = [];
      List<Leave> allList = [];

      if (response.statusCode == 200) {
        for (var item in jsonData) {
          Leave request = Leave.fromJson(item);
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
              (element) =>
                  element.applicationStatus == 'rejected' ||
                  element.applicationStatus == 'cancelled',
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
      printYellow("Loading Request Leaves");
    } catch (e) {
      emit(state.copyWith(
          errorMsg: 'please connect to your server',
          status: ApiServiceStatus.failed));
      emit(state.copyWith(status: ApiServiceStatus.initial));
    }
  }

  Future<void> responseApplyRequest(Leave leaveModel, String decision,
      String? rejectReason, bool isEmployee) async {
    emit(state.copyWith(status: ApiServiceStatus.loading));
    try {
      http.Response response = await CallApi()
          .patchRequest(leaveModel, decision, rejectReason, isEmployee);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final message = jsonData['message'];
        emit(state.copyWith(
            putRequestMsg: message, status: ApiServiceStatus.success));
        printGreen(message);
        isDoneCancel(message);
        emit(state.copyWith(status: ApiServiceStatus.initial));
      } else {
        final jsonData = jsonDecode(response.body);
        final message = jsonData['message'];
        printRed("${response.statusCode}: ${message}");
        emit(state.copyWith(
            putRequestMsg: message, status: ApiServiceStatus.failed));
        emit(state.copyWith(status: ApiServiceStatus.initial));
      }
    } catch (e) {
      print('Error SendApproval: $e');
    }
  }

  bool isDoneCancel(String message) {
    if (message == 'Leave application successfully submitted.') {
      return true;
    } else {
      return false;
    }
  }

  Future<void> applyLeave(
      {required String leaveTypeId,
      required DateTime startDate,
      required DateTime endDate,
      required String durationType,
      required String reason,
      required String? attachment}) async {
    printYellow("Applying Leave");
    emit(state.copyWith(status: ApiServiceStatus.loading));
    try {
      http.Response response = await CallApi().postLeavesApp(
          leaveTypeId: leaveTypeId,
          startDate: startDate,
          endDate: endDate,
          durationType: durationType,
          reason: reason,
          attachment: attachment);
      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        final message = jsonData['message'];
        printGreen("${response.statusCode} : $message");
        emit(state.copyWith(successApply: true, applyResponse: message));
      } else {
        final jsonData = jsonDecode(response.body);
        final message = jsonData['message'];
        final error = jsonData['error'];
        printRed("${response.statusCode} : $message");
        printRed("${response.statusCode} : $error");
      }
      emit(
          state.copyWith(status: ApiServiceStatus.success, successApply: true));
      Timer.periodic(const Duration(seconds: 2), (timer) {
        emit(state.copyWith(
            status: ApiServiceStatus.initial, successApply: false));
      });
    } catch (e) {
      printRed("ERROR applyLeave: $e");
      emit(state.copyWith(status: ApiServiceStatus.failed));
      emit(state.copyWith(status: ApiServiceStatus.initial));
    }
  }

  String doneApply() {
    return state.applyResponse!;
  }
}
