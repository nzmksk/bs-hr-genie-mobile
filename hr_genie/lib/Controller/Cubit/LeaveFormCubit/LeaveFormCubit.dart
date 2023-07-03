import 'package:bloc/bloc.dart';
import 'package:hr_genie/Constants/LeaveDuration.dart';
import 'package:hr_genie/Controller/Cubit/LeaveFormCubit/LeaveFormState.dart';

class LeaveFormCubit extends Cubit<LeaveFormState> {
  LeaveFormCubit() : super(LeaveFormState.initial());

  void typeOnChanged(String? type) {
    emit(state.copyWith(leaveType: type));
  }

  void inputChecking(String reason) {
    if (!RegExp(r"\s").hasMatch(reason) && reason.isNotEmpty) {
      emit(state.copyWith(isValidReason: true));
    } else if (reason.isEmpty) {
      emit(state.copyWith(isValidReason: false));
    }
  }

  void submitReason(String reason) {
    emit(state.copyWith(reason: () => reason));
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

  void setDateTime(DateTime? startDate) {
    emit(state.copyWith(startDate: startDate));
  }

  void setRangeDate(List<DateTime>? dateRange) {
    emit(state.copyWith(dateRange: dateRange));
  }
}
