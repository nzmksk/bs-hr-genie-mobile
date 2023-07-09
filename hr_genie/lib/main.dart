import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthCubit.dart';
import 'package:hr_genie/Controller/Cubit/LeaveFormCubit/LeaveFormCubit.dart';
import 'package:hr_genie/Controller/Cubit/RoutesCubit/RoutesCubit.dart';
import 'package:hr_genie/Controller/Cubit/UpdatePassword/UpdatePasswordCubit.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/ApiServiceCubit.dart';
import 'package:hr_genie/Routes/AppRoutes.dart';
import 'package:google_fonts/google_fonts.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

Future initialization(BuildContext? context) async {
  await Future.delayed(const Duration(seconds: 1));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  TextStyle whiteColor = const TextStyle(color: globalTextColor);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RoutesCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(create: (context) => UpdatePasswordCubit()),
        BlocProvider(create: (context) => ApiServiceCubit()),
        BlocProvider(create: (context) => LeaveFormCubit()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.from(
          textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context).textTheme.copyWith(
                  titleLarge: whiteColor,
                  titleMedium: whiteColor,
                  titleSmall: whiteColor,
                  bodySmall: whiteColor,
                  bodyMedium: whiteColor,
                  bodyLarge: whiteColor,
                  labelLarge: whiteColor,
                  labelMedium: whiteColor,
                  labelSmall: whiteColor,
                  displayLarge: whiteColor,
                  displayMedium: whiteColor,
                  displaySmall: whiteColor,
                ),
          ),
          colorScheme: const ColorScheme.light(
              primary: primaryBlue,
              onSecondary: Colors.white,
              secondary: Color.fromARGB(255, 255, 255, 255),
              background: primaryBlack),
        ).copyWith(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: SharedAxisPageTransitionsBuilder(
                transitionType: SharedAxisTransitionType.scaled,
              ),
            },
          ),
        ),
        routerDelegate: AppRouter.router.routerDelegate,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routeInformationProvider: AppRouter.router.routeInformationProvider,
      ),
    );
  }
}
