import 'package:equatable/equatable.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';

enum BottomNavItems { leaveScreen, accountScreen }

enum RouteStatus { initial, loading, success, error }

class RoutesCubitState extends Equatable {
  final String? bottomNavItems;
  final int? index;
  final RouteStatus status;

  const RoutesCubitState(
      {this.bottomNavItems, this.index, required this.status});

  factory RoutesCubitState.initial() {
    return RoutesCubitState(
        bottomNavItems: PAGES.leave.screenName,
        index: 0,
        status: RouteStatus.initial);
  }
  @override
  List<Object> get props => [bottomNavItems!, index!];
}
