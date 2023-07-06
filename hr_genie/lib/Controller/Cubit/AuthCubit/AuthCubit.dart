// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:io';

import 'package:hr_genie/Model/ResponseBodyModel.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthState.dart';
import 'package:hr_genie/Controller/Services/CallApi.dart';
import 'package:hr_genie/Routes/AppRoutes.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());
  Future<bool> isLogged() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    if (email != null) {
      print("You Logged as $email");
      return true;
    }
    return false;
  }

  void emailChanged(String value) {
    bool emailValid = EmailValidator.validate(value);
    emit(state.copyWith(validPass: true));
    if (emailValid) {
      emit(state.copyWith(
          email: value,
          validEmail: true,
          status: AuthStatus.initial,
          loading: true));
    } else {
      emit(state.copyWith(
          email: value, validEmail: false, status: AuthStatus.initial));
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

  void signIn(String email, String password, BuildContext context) async {
    try {
      final http.Response response = await CallApi().postLogin(
        email: email,
        password: password,
      );

      ResponseBody responseBody =
          ResponseBody.fromJson(jsonDecode(response.body));

      if (response.statusCode == 200) {
        AppRouter.router.go(PAGES.leave.screenPath);

        final rawCookie = response.headers['set-cookie'];
        late final Cookie parsedCookie;

        if (rawCookie != null) {
          parsedCookie = Cookie.fromSetCookieValue(rawCookie);
        }

        emit(state.copyWith(
          isExist: true,
          validPass: true,
          validEmail: true,
          status: AuthStatus.success,
          accessToken: responseBody.token,
          refreshToken: parsedCookie.value,
        ));
      } else {
        emit(state.copyWith(
          validEmail: false,
          isExist: false,
          errorMessage: responseBody.error,
          status: AuthStatus.error,
        ));
      }
    } catch (error) {
      if (error is http.ClientException || error is SocketException) {
        emit(state.copyWith(
          validEmail: false,
          isExist: false,
          errorMessage: "Server unavailable",
          status: AuthStatus.error,
        ));
      }
    }
  }

  void signOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
  }
}
