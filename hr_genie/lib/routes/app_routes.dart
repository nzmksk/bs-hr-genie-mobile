import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hr_genie/cubit/routes_cubit/routes_cubit.dart';
import 'package:hr_genie/routes/routes_utils.dart';
import 'package:hr_genie/view/accountDetailPage.dart';
import 'package:hr_genie/view/accountpage.dart';
import 'package:hr_genie/view/homepage.dart';
import 'package:hr_genie/view/leavepage.dart';
// import 'package:hr_genie/view/leavePage.dart';
import 'package:hr_genie/view/loginpage.dart';
import 'package:hr_genie/view/notfound.dart';
import 'package:hr_genie/view/splashScreen.dart';
import 'package:hr_genie/view/testPage.dart';

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
      ),
      // GoRoute(
      //   parentNavigatorKey: _rootNavigatorKey,
      //   path: PAGES.home.screenPath,
      //   name: PAGES.home.screenName,
      //   builder: (context, state) {
      //     return const TestPage();
      //   },
      // ),
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
                ]),
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
