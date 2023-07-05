// ignore_for_file: avoid_print

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthState.dart';
import 'package:hr_genie/Routes/AppRoutes.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());
  Future<bool> isLogged() async {
    emit(state.copyWith(status: AuthStatus.loading));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    if (email != null) {
      print("You Logged as $email");
      return true;
    }
    emit(state.copyWith(status: AuthStatus.notLogged));
    return false;
  }

  void emailChanged(String value) {
    bool emailValid = EmailValidator.validate(value);
    emit(state.copyWith(validPass: true, status: AuthStatus.notLogged));
    if (emailValid) {
      emit(state.copyWith(
          email: value,
          validEmail: true,
          status: AuthStatus.notLogged,
          loading: true));
    } else {
      emit(state.copyWith(
          email: value, validEmail: false, status: AuthStatus.notLogged));
    }
  }

  void passwordChanged(String value) {
    if (value == "") {
      emit(state.copyWith(validPass: true, status: AuthStatus.notLogged));
    } else {
      emit(state.copyWith(password: value, status: AuthStatus.notLogged));
    }
  }

  void signIn(String email, String password, BuildContext context) async {
    emit(state.copyWith(status: AuthStatus.loading));
    // await Future.delayed(Duration(seconds: 3));
    if (email == "test@gmail.com" && password == "123456") {
      AppRouter.router.go(PAGES.leave.screenPath);
      emit(state.copyWith(
          isExist: true,
          validPass: true,
          validEmail: true,
          status: AuthStatus.loggedIn));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', state.email);
    } else if (email != "test@gmail.com") {
      emit(state.copyWith(
          validEmail: false, isExist: false, status: AuthStatus.error));
    } else if (password != "123456") {
      emit(state.copyWith(
          validPass: false,
          validEmail: true,
          isExist: true,
          status: AuthStatus.error));
    }
  }

  void signOut(BuildContext context) async {
    emit(state.copyWith(email: "", password: "", status: AuthStatus.loading));
    try {
      // await Future.delayed(const Duration(seconds: 2));
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('email');
      emit(state.copyWith(status: AuthStatus.notLogged));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }
}
