import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hr_genie/routes/AppRoutes.dart';

import '../routes/RoutesUtils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 1),
      () => AppRouter.router.go(PAGES.login.screenPath),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset("assets/md.png"),
    );
  }
}
