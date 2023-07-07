import 'package:bloc/bloc.dart';
import 'package:hr_genie/Routes/AppRoutes.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';

import 'RoutesState.dart';

class RoutesCubit extends Cubit<RoutesCubitState> {
  RoutesCubit() : super(RoutesCubitState.initial());
  void goToApplyLeave() async {
    emit(RoutesCubitState(
        status: RouteStatus.loading,
        bottomNavItems: PAGES.leave.screenName,
        index: 0));
    // print("STATUS: ${state.status}");
    // await Future.delayed( Duration(seconds: 1));
    try {
      await AppRouter.router
          .push("${PAGES.leave.screenPath}/${PAGES.leaveApp.screenPath}");
      emit(RoutesCubitState(
          status: RouteStatus.success,
          bottomNavItems: PAGES.leave.screenName,
          index: 0));
      emit(RoutesCubitState(
          status: RouteStatus.initial,
          bottomNavItems: PAGES.leave.screenName,
          index: 0));
      // print("STATUS: ${state.status}");
    } catch (e) {
      emit(RoutesCubitState(
          status: RouteStatus.error,
          bottomNavItems: PAGES.leave.screenName,
          index: 0));
      // print("STATUS: ${state.status}");
    }
  }

  void goToRequestBar() {
    emit(RoutesCubitState(
        bottomNavItems: PAGES.request.screenName,
        index: 1,
        status: RouteStatus.initial));
  }

  void employeeNavBarItem(int index) {
    switch (index) {
      case 0:
        emit(RoutesCubitState(
            bottomNavItems: PAGES.leave.screenName,
            index: 0,
            status: RouteStatus.initial));
        break;
      case 1:
        emit(RoutesCubitState(
            bottomNavItems: PAGES.account.screenName,
            index: 1,
            status: RouteStatus.initial));
        break;
    }
  }

  void managerNavBarItem(int index) {
    switch (index) {
      case 0:
        emit(RoutesCubitState(
            bottomNavItems: PAGES.leave.screenName,
            index: 0,
            status: RouteStatus.initial));
        break;
      case 1:
        emit(RoutesCubitState(
            bottomNavItems: PAGES.request.screenName,
            index: 1,
            status: RouteStatus.initial));
        break;
      case 2:
        emit(RoutesCubitState(
            bottomNavItems: PAGES.account.screenName,
            index: 2,
            status: RouteStatus.initial));
        break;
    }
  }
}
