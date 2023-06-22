import 'package:bloc/bloc.dart';
import 'package:hr_genie/Controller/Cubit/UpdatePassword/UpdatePasswordState.dart';
import 'package:hr_genie/Controller/Services/PasswordValidator.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  UpdatePasswordCubit() : super(UpdatePasswordState.initial());

  void newPasswordChanged(String value) {
    emit(state.copyWith(
        newPassword: value, status: UpdatePasswordStatus.initial));
    bool isValidated =
        PasswordValidatorService.isStrongPassword(state.newPassword);
    if (!isValidated && state.newPassword != "") {
      emit(state.copyWith(newPassValid: false));
      print("password not stronk");
      print("${state.newPassword} is ${state.newPassValid}");
    } else {
      emit(state.copyWith(newPassValid: true));
    }
  }

  void repeatPasswordChanged(String value) {
    emit(
      state.copyWith(
          repeatPassword: value, status: UpdatePasswordStatus.initial),
    );
    if (state.newPassword == state.repeatPassword) {
      emit(
        state.copyWith(isMatched: true),
      );
    }
  }
}
