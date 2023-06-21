// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:hr_genie/controller/cubit/AuthCubit/AuthState.dart';
import 'package:hr_genie/routes/AppRoutes.dart';
import 'package:hr_genie/routes/RoutesUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  void signIn(String email, String password, context, bool rememberMe) {
    if (email == "test@gmail.com" && password == "123456") {
      if (rememberMe) {
        emit(state.copyWith(
            email: state.email,
            password: state.password,
            rememberMe: rememberMe));
      }

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

  void handleRememberMe(bool value) {
    print("Handle Remember Me");
    // _isChecked = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", state.rememberMe);
        prefs.setString('email', state.email);
        prefs.setString('password', state.password);
      },
    );
    emit(state.copyWith(rememberMe: value));
    // setState(() {
    //   _isChecked = value;
    // });
  }

  void loadUserEmailPassword() async {
    print("Load Email");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString("email") ?? "";
      var password = prefs.getString("password") ?? "";
      var rememberMe = prefs.getBool("remember_me") ?? false;

      print(rememberMe);
      print(email);
      print(password);
      if (rememberMe) {
        emit(state.copyWith(
          rememberMe: true,
        ));

        // setState(() {
        //   _isChecked = true;
        // });
        // _emailController.text = _email ?? "";
        // _passwordController.text = _password ?? "";
      }
    } catch (e) {
      print(e);
    }
  }
}
