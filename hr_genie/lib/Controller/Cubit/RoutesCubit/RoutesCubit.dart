import 'package:bloc/bloc.dart';
import 'package:hr_genie/Routes/AppRoutes.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';

import 'RoutesState.dart';

class RoutesCubit extends Cubit<RoutesCubitState> {
  RoutesCubit() : super(RoutesCubitState.initial());
  void goToApplication() async {
    emit(const RoutesCubitState(
        status: RouteStatus.loading, bottomNavItems: '', index: 0));
    // print("STATUS: ${state.status}");
    // await Future.delayed(const Duration(seconds: 1));
    try {
      await AppRouter.router
          .push("${PAGES.leave.screenPath}/${PAGES.leaveApp.screenPath}");
      emit(const RoutesCubitState(
          status: RouteStatus.success, bottomNavItems: '', index: 0));
      emit(const RoutesCubitState(
          status: RouteStatus.initial, bottomNavItems: '', index: 0));
      // print("STATUS: ${state.status}");
    } catch (e) {
      emit(const RoutesCubitState(
          status: RouteStatus.error, bottomNavItems: '', index: 0));
      // print("STATUS: ${state.status}");
    }
  }

  void getNavBarItem(int index) {
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
}
