import 'package:bloc/bloc.dart';
import 'package:hr_genie/Model/LeaveModel.dart';
import 'package:hr_genie/Routes/AppRoutes.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';

import 'RoutesState.dart';

class RoutesCubit extends Cubit<RoutesCubitState> {
  RoutesCubit() : super(RoutesCubitState.initial());
  void goToApplyLeave() async {
    await routeToPage("${PAGES.leave.screenPath}/${PAGES.leaveApp.screenPath}",
        RouteStatus.loadingLeaveApplication);
  }

  void goToLeaveDetail(Leave leaveModel) async {
    await routePassToPage(
        "${PAGES.leave.screenPath}/${PAGES.leaveDetails.screenPath}",
        leaveModel,
        RouteStatus.loadingLeaveDetails,
        0);
  }

  void goToRequestDetail(Leave request) async {
    await routePassToPage(
        "${PAGES.request.screenPath}/${PAGES.requestDetails.screenPath}",
        request,
        RouteStatus.loadingRequestDetails,
        1);
  }

  Future<void> routeToPage(String location, RouteStatus loading) async {
    emit(RoutesCubitState(
        status: loading, bottomNavItems: PAGES.leave.screenName, index: 0));

    try {
      await AppRouter.router.push(
        location,
      );
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

  Future<void> routePassToPage(
      String location, Leave extra, RouteStatus loading, int index) async {
    emit(RoutesCubitState(
        status: loading, bottomNavItems: PAGES.leave.screenName, index: index));
    try {
      await AppRouter.router.push(location, extra: extra);
      emit(RoutesCubitState(
          status: RouteStatus.success,
          bottomNavItems: PAGES.leave.screenName,
          index: index));
      emit(RoutesCubitState(
          status: RouteStatus.initial,
          bottomNavItems: PAGES.leave.screenName,
          index: index));
    } catch (e) {
      emit(RoutesCubitState(
          status: RouteStatus.error,
          bottomNavItems: PAGES.leave.screenName,
          index: index));
    }
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
