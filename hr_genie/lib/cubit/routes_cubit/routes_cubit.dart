import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'routes_state.dart';

class RoutesCubit extends Cubit<RoutesCubitState> {
  RoutesCubit()
      : super(const RoutesCubitState(bottomNavItems: "LEAVE", index: 0));

  void getNavBarItem(int index) {
    switch (index) {
      case 0:
        emit(const RoutesCubitState(bottomNavItems: "LEAVE", index: 0));
        break;
      case 1:
        emit(const RoutesCubitState(bottomNavItems: "ACCOUNT", index: 1));
        break;
    }
  }
}
