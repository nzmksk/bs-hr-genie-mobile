import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hr_genie/Constants/LeaveDuration.dart';
import 'package:hr_genie/Controller/Cubit/LeaveFormCubit/LeaveFormState.dart';

class LeaveFormCubit extends Cubit<LeaveFormState> {
  LeaveFormCubit() : super(LeaveFormState.initial());
  void resetForm() {
    emit(state.copyWith(
      reason: () => null,
      duration: null,
      leaveType: () => null,
    ));
  }

  void successApply(bool isSuccess) {
    emit(state.copyWith(successApply: isSuccess));
    Timer.periodic(const Duration(seconds: 3), (timer) {
      emit(state.copyWith(successApply: false));
    });
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
}
