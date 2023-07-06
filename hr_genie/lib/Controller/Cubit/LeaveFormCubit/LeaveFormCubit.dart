import 'package:bloc/bloc.dart';
import 'package:hr_genie/Constants/LeaveDuration.dart';
import 'package:hr_genie/Controller/Cubit/LeaveFormCubit/LeaveFormState.dart';

class LeaveFormCubit extends Cubit<LeaveFormState> {
  LeaveFormCubit() : super(LeaveFormState.initial());

  void typeOnChanged(String? type) {
    emit(state.copyWith(firstStepDone: false));
    if (type == null) {
      emit(state.copyWith(leaveType: "initial", isValidLeaveType: false));
    } else {
      emit(state.copyWith(leaveType: type, isValidLeaveType: true));
    }
    print("Running type changed: ${state.leaveType}");
  }

  void inputChecking(String reason) {
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

  void firstStepDone() => emit(state.copyWith(firstStepDone: true));
  void secStepDone() => emit(state.copyWith(secStepDone: true));
  void thirdStepDone() => emit(state.copyWith(thirdStepDone: true));

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
