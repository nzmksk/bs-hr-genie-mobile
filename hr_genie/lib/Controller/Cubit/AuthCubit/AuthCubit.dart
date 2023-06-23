// ignore_for_file: avoid_print

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthState.dart';
import 'package:hr_genie/Routes/AppRoutes.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());

  void emailChanged(String value) {
    bool emailValid = EmailValidator.validate(value);
    if (emailValid) {
      emit(state.copyWith(
          email: value,
          validEmail: true,
          status: AuthStatus.initial,
          loading: true));
    } else {
      emit(state.copyWith(
          email: value, validEmail: false, status: AuthStatus.error));
    }
  }

  void passwordChanged(String value) {
    if (value == "") {
      emit(state.copyWith(validPass: true));
      print("password is empty");
    } else {
      emit(state.copyWith(password: value, status: AuthStatus.initial));
    }
  }

  void signIn(String email, String password, context) {
    if (email == "test@gmail.com" && password == "123456") {
      AppRouter.router.go(PAGES.leave.screenPath);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You're logged as test@gmail.com"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      emit(state.copyWith(validPass: false, validEmail: false));
    }
  }
}
