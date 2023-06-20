// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hr_genie/cubit/auth_cubit/auth_state.dart';
import 'package:hr_genie/routes/app_routes.dart';
import 'package:hr_genie/routes/routes_utils.dart';
// import 'package:meta/meta.dart';

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
          email: "", validEmail: false, status: AuthStatus.error));
    }
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: AuthStatus.initial));
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
    } else if (password != "123456") {
      emit(state.copyWith(validPass: false));
    }
  }
}
