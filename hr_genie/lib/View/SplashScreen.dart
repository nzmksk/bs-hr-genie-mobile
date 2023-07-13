// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/ApiServiceCubit.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthCubit.dart';
import 'package:hr_genie/Controller/Services/CachedStation.dart';
import 'package:hr_genie/Routes/AppRoutes.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> checkingUser() async {
    final accessToken = await CacheStore().getCache('access_token');
    final userRole = await CacheStore().getCache('user_role');
    final updatedPass = await CacheStore().getBoolCache('updated_password');

    context.read<AuthCubit>().setUserRole(userRole);

    Future<bool> check = context.read<AuthCubit>().isLogged();
    if (accessToken != null) {
      context.read<ApiServiceCubit>().getLeaveQuota(accessToken);
    } else {
      print("NotLogged: Qouta Data is null");
    }

    AppRouter.router.go(await check && updatedPass!
        ? PAGES.leave.screenPath
        : PAGES.login.screenPath);
  }

  @override
  void initState() {
    super.initState();
    checkingUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryBlack,
      child: Image.asset("assets/logo.png"),
    );
  }
}
