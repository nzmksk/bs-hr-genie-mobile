import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hr_genie/Constants/LeaveDuration.dart';
import 'package:hr_genie/Constants/PrintColor.dart';
import 'package:hr_genie/Controller/Cubit/LeaveFormCubit/LeaveFormState.dart';
import 'package:hr_genie/Controller/Services/CallApi.dart';
import 'package:http/http.dart' as http;

class LeaveFormCubit extends Cubit<LeaveFormState> {
  LeaveFormCubit() : super(LeaveFormState.initial());
  void resetForm() {
    emit(state.copyWith(
      reason: () => null,
      duration: null,
      leaveType: () => null,
    ));
  }

  Future<void> emitApplyResponse(String applyResponse) async {
    emit(state.copyWith(
      applyResponse: applyResponse,
    ));
  }

  void typeOnChanged(String? type) {
    emit(state.copyWith(firstStepDone: false));
    if (type == null) {
      emit(state.copyWith(leaveType: () => null, isValidLeaveType: false));
    } else {
      emit(state.copyWith(leaveType: () => type, isValidLeaveType: true));
    }
  }

  void inputChecking(String reason, bool rejectReason) {
    if (rejectReason) {
      rejectReasonEmit(reason);
    } else {
      applyReasonEmit(reason);
    }
  }

  void rejectReasonEmit(String reason) {
    if (reason.isNotEmpty) {
      emit(state.copyWith(rejectReasonNotEmpty: true));
    } else {
      emit(state.copyWith(rejectReasonNotEmpty: false));
    }
  }

  void applyReasonEmit(String reason) {
    if (reason.isNotEmpty) {
      emit(state.copyWith(isValidReason: true));
    } else {
      emit(state.copyWith(isValidReason: false));
    }
  }

  void submitReason(String reason) {
    emit(state.copyWith(reason: () => reason, isValidReason: false));
  }

  void resetReason() {
    emit(state.copyWith(isValidReason: false, reason: () => null));
    print("RESET");
  }

  void durationSelected(int selectedDuration, int whichHalf) {
    if (selectedDuration == 1) {
      emit(state.copyWith(duration: LeaveDuration.fullDay.value));
    } else if (selectedDuration == 2) {
      if (whichHalf == 1) {
        emit(state.copyWith(duration: LeaveDuration.firstHalf.value));
      } else {
        emit(state.copyWith(duration: LeaveDuration.secondHalf.value));
      }
    }
  }

  void firstStepDone(bool done) => emit(state.copyWith(firstStepDone: done));
  void secStepDone(bool done) => emit(state.copyWith(secStepDone: done));
  void thirdStepDone(bool done) => emit(state.copyWith(thirdStepDone: done));

  void setDateTime(DateTime? startDate) {
    if (startDate == null) {
      emit(state.copyWith(startDate: () => null));
    } else {
      emit(state.copyWith(startDate: () => startDate));
    }
  }

  void setRangeDate(DateTime? startDate, endDate) {
    if (startDate == null && endDate == null) {
      emit(state.copyWith(startDate: () => null, endDate: () => null));
      print("Running null placement");
    } else {
      emit(state.copyWith(startDate: () => startDate, endDate: () => endDate));
      print(
          "VALUE placement, startDat: ${state.startDate}, endDate: ${state.endDate}");
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
    emit(state.copyWith(status: LeaveStatus.loading));
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
        emit(state.copyWith(applyResponse: message));
        emit(state.copyWith(status: LeaveStatus.sent, applyResponse: message));
      } else {
        final jsonData = jsonDecode(response.body);
        final message = jsonData['message'];
        final error = jsonData['error'];
        printRed("${response.statusCode} : $message");
        printRed("${response.statusCode} : $error");
        emit(state.copyWith(status: LeaveStatus.error, applyResponse: error));
      }
      Timer.periodic(const Duration(seconds: 2), (timer) {
        emit(state.copyWith(status: LeaveStatus.initial));
      });
    } catch (e) {
      printRed("ERROR applyLeave: $e");
      emit(state.copyWith(status: LeaveStatus.error));
      emit(state.copyWith(status: LeaveStatus.initial));
    }
  }
}
