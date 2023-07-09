import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthCubit.dart';
import 'package:hr_genie/Routes/AppRoutes.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<bool> check = context.read<AuthCubit>().isLogged();

    Timer(
      const Duration(seconds: 1),
      () async => AppRouter.router
          .go(await check ? PAGES.leave.screenPath : PAGES.leave.screenPath),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryBlack,
      child: Image.asset("assets/logo.png"),
    );
  }
}
