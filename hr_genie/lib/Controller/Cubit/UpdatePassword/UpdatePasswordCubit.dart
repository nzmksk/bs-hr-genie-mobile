import 'package:bloc/bloc.dart';
import 'package:hr_genie/Controller/Cubit/UpdatePassword/UpdatePasswordState.dart';
import 'package:hr_genie/Controller/Services/PasswordValidator.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  UpdatePasswordCubit() : super(UpdatePasswordState.initial());

  void newPasswordChanged(String value) {
    emit(state.copyWith(
      newPassword: value,
      status: UpdatePasswordStatus.initial,
      repeatPassEmpty: true,
    ));
    bool isValidated =
        PasswordValidatorService.isStrongPassword(state.newPassword);

    if (!isValidated && state.newPassword != "") {
      emit(state.copyWith(newPassValid: false));
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
    } else {
      emit(state.copyWith(isMatched: false));
      if (state.repeatPassword.isEmpty || state.repeatPassword == "") {
        emit(state.copyWith(repeatPassEmpty: true));
      } else {
        emit(state.copyWith(repeatPassEmpty: false));
      }
    }
  }
}
