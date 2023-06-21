import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hr_genie/routes/RoutesUtils.dart';
import 'package:hr_genie/view/AccountDetailPage.dart';
import 'package:hr_genie/view/AccountPage.dart';
import 'package:hr_genie/view/ForgotPassword.dart';
import 'package:hr_genie/view/HomePage.dart';
import 'package:hr_genie/view/LeavePage.dart';
import 'package:hr_genie/view/LoginPage.dart';
import 'package:hr_genie/view/NotFoundPage.dart';
import 'package:hr_genie/view/SplashScreen.dart';

import '../controller/cubit/RoutesCubit/RoutesCubit.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: PAGES.home.screenPath,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
          parentNavigatorKey: _rootNavigatorKey,
          path: PAGES.home.screenPath,
          name: PAGES.home.screenName,
          builder: (context, state) {
            return const SplashScreen();
          },
          routes: []),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) => RoutesCubit(),
            child: HomePage(screen: child),
          );
        },
        routes: [
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: PAGES.account.screenPath,
            name: PAGES.account.screenName,
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: AccountPage());
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: PAGES.leave.screenPath,
            name: PAGES.leave.screenName,
            pageBuilder: (context, state) {
              return const NoTransitionPage(child: LeavePage());
            },
            routes: [
              GoRoute(
                parentNavigatorKey: _shellNavigatorKey,
                path: PAGES.leaveDetails.screenPath,
                name: PAGES.leaveDetails.screenName,
                builder: (context, state) {
                  return const AccountDetailsPage();
                },
              )
            ],
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: PAGES.login.screenPath,
        name: PAGES.login.screenName,
        builder: (context, state) {
          return const LoginPage();
        },
        routes: [
          GoRoute(
            parentNavigatorKey: _rootNavigatorKey,
            path: PAGES.forgotPassword.screenPath,
            name: PAGES.forgotPassword.screenName,
            builder: (context, state) {
              return const ForgotPassword();
            },
          )
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );

  static GoRouter get router => _router;
}
