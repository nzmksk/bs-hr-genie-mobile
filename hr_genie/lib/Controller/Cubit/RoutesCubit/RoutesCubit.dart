import 'package:bloc/bloc.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';

import 'RoutesState.dart';

class RoutesCubit extends Cubit<RoutesCubitState> {
  RoutesCubit() : super(RoutesCubitState.initial());

  void getNavBarItem(int index) {
    switch (index) {
      case 0:
        emit(RoutesCubitState(
            bottomNavItems: PAGES.leave.screenName,
            index: 0,
            status: RouteStatus.success));
        break;
      case 1:
        emit(RoutesCubitState(
            bottomNavItems: PAGES.account.screenName,
            index: 1,
            status: RouteStatus.success));
        break;
    }
  }
}
