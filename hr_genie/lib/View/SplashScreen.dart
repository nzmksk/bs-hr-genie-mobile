import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          .go(await check ? PAGES.leave.screenPath : PAGES.login.screenPath),
    );
  }

  //  Future<String> checkLog()async{
  //   var isItin = context.read<AuthCubit>().isLogged();

  //   if(isItin){

  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset("assets/md.png"),
    );
  }
}
