// ignore_for_file: avoid_print, use_build_context_synchronously
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:hr_genie/Components/CustomSnackBar.dart';
import 'package:hr_genie/Constants/PrintColor.dart';
import 'package:hr_genie/Controller/Services/CachedStation.dart';
import 'package:hr_genie/Model/EmployeeModel.dart';
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
    emit(state.copyWith(status: AuthStatus.loading));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("email");
    final userDataRes = prefs.getString("user_data");

    if (userDataRes != null) {
      final jsonData = json.decode(userDataRes);
      final Map<String, dynamic> data = jsonData['data'];
      final employee = Employee.fromJson(data);
      emit(state.copyWith(userData: employee));
    } else {
      print("NotLogged: User Data is null");
    }

    String? accessToken = prefs.getString('access_token');
    print("email in Shared Preferences: $email");
    if (email != null && accessToken != null) {
      print("You Logged as $email");
      print("Your Token is $accessToken");
      emit(state.copyWith(status: AuthStatus.loggedIn));

      return true;
    }
    emit(state.copyWith(status: AuthStatus.notLogged));
    return false;
  }

  void emailChanged(String value) async {
    bool emailValid = EmailValidator.validate(value);
    emit(state.copyWith(validPass: true, status: AuthStatus.notLogged));
    await Future.delayed(const Duration(milliseconds: 900));
    if (emailValid) {
      emit(state.copyWith(
        email: value,
        validEmail: true,
        status: AuthStatus.notLogged,
      ));
    } else {
      emit(state.copyWith(
          email: value, validEmail: false, status: AuthStatus.notLogged));
    }
  }

  void passwordChanged(String value) async {
    await Future.delayed(const Duration(milliseconds: 900));

    if (value == "") {
      emit(state.copyWith(validPass: true, status: AuthStatus.notLogged));
    } else {
      emit(state.copyWith(password: value, status: AuthStatus.notLogged));
    }
  }

  Future<void> fetchUserData() async {
    print("Fetching User Data");
    Employee userData = await CallApi().getUserData();

    emit(state.copyWith(userData: userData));
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
        // late final Cookie parsedCookie;
        final jsonData = json.decode(response.body);
        final accessToken = jsonData['token'];

        final Map<String, dynamic> data = jsonData['data'];
        final employee = Employee.fromJson(data);
        final userRole = employee.employeeRole;
        await CacheStore().setCache('user_role', userRole!);
        final bool isManager = userRole == 'manager' ? true : false;

        if (rawCookie != null) {
          // parsedCookie = Cookie.fromSetCookieValue(rawCookie);
          await CacheStore().setCache('refresh_token', rawCookie);
          // prefs.setString('refresh_token', rawCookie);
          print("rawCookie: $rawCookie");
        }
        await CacheStore().setCache('access_token', accessToken);
        await CacheStore().setCache('user_data', response.body);
        // prefs.setString('access_token', accessToken);
        // prefs.setString('user_data', response.body);
        emit(state.copyWith(
          isExist: true,
          validPass: true,
          validEmail: true,
          status: AuthStatus.loggedIn,
          userData: employee,
          isManager: isManager,
        ));
        CallApi().getUserData();
        printYellow("User Role: $userRole");
        printYellow("isManager: ${state.isManager}");
        printGreen("Done Fetch User Data");
      } else {
        emit(state.copyWith(
          validEmail: false,
          isExist: false,
          errorMessage: responseBody.error,
          status: AuthStatus.error,
        ));
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
    } catch (error) {
      if (error is http.ClientException || error is SocketException) {
        emit(state.copyWith(
          validEmail: false,
          isExist: false,
          errorMessage: "Server unavailable",
          status: AuthStatus.error,
        ));
        emit(state.copyWith(status: AuthStatus.notLogged));
        print("STATUS: ${state.status}");
      }
    }
  }

  void signOut(BuildContext context) async {
    emit(state.copyWith(email: "", password: "", status: AuthStatus.loading));
    try {
      final accessToken = await CacheStore().getCache('access_token');
      await CallApi().postLogout(accessToken!);
      await CacheStore().removeAll();
      emit(state.copyWith(status: AuthStatus.notLogged));
      showSnackBar(context, 'Successfully Log out', Colors.green);
      printGreen("Successfully Log out");
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
      emit(state.copyWith(status: AuthStatus.notLogged));
    }
  }

  void setUserRole(String? role) {
    if (role == 'manager') {
      emit(state.copyWith(isManager: true));
      printYellow("User is a MANAGER");
    } else {
      emit(state.copyWith(isManager: false));
      printYellow("User is a EMPLOYEE");
    }
  }
}
