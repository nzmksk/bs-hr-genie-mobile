import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hr_genie/cubit/routes_cubit/routes_cubit.dart';
import 'package:hr_genie/routes/routes_utils.dart';
import 'package:hr_genie/view/accountpage%20copy.dart';
import 'package:hr_genie/view/homepage.dart';
import 'package:hr_genie/view/leavePage.dart';
import 'package:hr_genie/view/loginpage.dart';
import 'package:hr_genie/view/notfound.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: "/leave",
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
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
              path: PAGES.leave.screenPath,
              pageBuilder: (context, state) {
                return const NoTransitionPage(child: AccountPage());
              },
            ),
            GoRoute(
              path: PAGES.account.screenPath,
              pageBuilder: (context, state) {
                return const NoTransitionPage(child: AccountPage());
              },
            ),
          ]),
      // GoRoute(
      //     path: PAGES.home.screenPath,
      //     name: PAGES.home.screenName,
      //     builder: (context, state,) {
      //       return  HomePage();
      //     }),
      GoRoute(
          path: PAGES.login.screenPath,
          name: PAGES.login.screenName,
          builder: (context, state) {
            return const LoginPage();
          }),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );

  static GoRouter get router => _router;
}
