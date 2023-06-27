import 'package:bloc/bloc.dart';
import 'package:hr_genie/Constants/LeaveCategories.dart';
import 'package:hr_genie/Controller/Cubit/LeaveFormCubit/LeaveFormState.dart';

class LeaveFormCubit extends Cubit<LeaveFormState> {
  LeaveFormCubit() : super(LeaveFormState.initial());

  void typeOnChanged(TYPE type) {
    emit(state.copyWith(leaveType: type));
  }
}
