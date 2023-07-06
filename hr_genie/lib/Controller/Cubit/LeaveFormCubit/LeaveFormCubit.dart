import 'package:bloc/bloc.dart';
import 'package:hr_genie/Controller/Cubit/LeaveFormCubit/LeaveFormState.dart';

class LeaveFormCubit extends Cubit<LeaveFormState> {
  LeaveFormCubit() : super(LeaveFormState.initial());
}
