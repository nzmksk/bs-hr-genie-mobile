import 'package:equatable/equatable.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';

enum BottomNavItems { leaveScreen, accountScreen }

enum RouteStatus {
  initial,
  loadingLeavePage,
  success,
  error,
  loadingLeaveApplication,
  loadingLeaveDetails,
  loadingRequestDetails,
}

class RoutesCubitState extends Equatable {
  final String bottomNavItems;
  final int index;
  final RouteStatus status;

  const RoutesCubitState(
      {required this.bottomNavItems,
      required this.index,
      required this.status});

  // RoutesCubitState copyWith({
  //   RouteStatus? status,
  // }) {
  //   return const RoutesCubitState(
  //       status: RouteStatus.initial, bottomNavItems: '', index: 0);
  // }

  factory RoutesCubitState.initial() {
    return RoutesCubitState(
        bottomNavItems: PAGES.leave.screenName,
        index: 0,
        status: RouteStatus.initial);
  }

  @override
  List<Object> get props => [bottomNavItems, index, status];
}
