import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hr_genie/Controller/Cubit/RoutesCubit/RoutesCubit.dart';
import 'package:hr_genie/Model/LeaveModel.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';
import 'package:hr_genie/View/AccountDetailPage.dart';
import 'package:hr_genie/View/AccountPage.dart';
import 'package:hr_genie/View/HomePage.dart';
import 'package:hr_genie/View/LeaveApplication.dart';
import 'package:hr_genie/View/LeaveDetailPage.dart';
import 'package:hr_genie/View/LeavePage.dart';
import 'package:hr_genie/View/LoginPage.dart';
import 'package:hr_genie/View/NotFoundPage.dart';
import 'package:hr_genie/View/PasswordUpdate.dart';
import 'package:hr_genie/View/RequestDetailsPage.dart';
import 'package:hr_genie/View/RequestPage.dart';
import 'package:hr_genie/View/SplashScreen.dart';
import 'package:hr_genie/View/TestPage.dart';
import 'package:hr_genie/View/TestPage2.dart';

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
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) => RoutesCubit(),
            child: HomePage(
              screen: child,
            ),
          );
        },
        routes: [
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: PAGES.account.screenPath,
            name: PAGES.account.screenName,
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: AccountPage(),
              );
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: PAGES.request.screenPath,
            name: PAGES.request.screenName,
            pageBuilder: (context, state) {
              return NoTransitionPage(child: RequestPage());
            },
            routes: [
              GoRoute(
                parentNavigatorKey: _shellNavigatorKey,
                path: PAGES.requestDetails.screenPath,
                name: PAGES.requestDetails.screenName,
                builder: (context, state) {
                  return const RequestDetailPage();
                },
              ),
            ],
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
                  final leaveModel = state.extra as Leave;
                  return LeaveDetailPage(
                    leaveModel: leaveModel,
                  );
                },
              ),
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: PAGES.leaveApp.screenPath,
                name: PAGES.leaveApp.screenName,
                builder: (context, state) {
                  return const LeaveApplicationPage();
                },
              ),
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
            path: PAGES.passwordUpdate.screenPath,
            name: PAGES.passwordUpdate.screenName,
            builder: (context, state) {
              return WillPopScope(
                  onWillPop: () async => false,
                  child: const PasswordUpdateForm());
            },
          )
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );

  static GoRouter get router => _router;
}
