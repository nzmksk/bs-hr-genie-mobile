part of 'RoutesCubit.dart';

enum BottomNavItems { leaveScreen, accountScreen }

class RoutesCubitState extends Equatable {
  final String bottomNavItems;
  final int index;

  const RoutesCubitState({required this.bottomNavItems, required this.index});

  @override
  List<Object> get props => [bottomNavItems, index];
}

class RoutesCubitInitial extends RoutesCubitState {
  const RoutesCubitInitial(
      {required super.bottomNavItems, required super.index});
}
