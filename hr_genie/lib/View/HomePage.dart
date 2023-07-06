import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hr_genie/Components/BottomNavBarWithRoutes.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/RoutesCubit/RoutesCubit.dart';
import 'package:hr_genie/Controller/Cubit/RoutesCubit/RoutesState.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';

class HomePage extends StatelessWidget {
  final Widget screen;
  HomePage({super.key, required this.screen});

  final tabs = [
    BottomNavigationBarRoute(
      initialLocation: PAGES.leave.screenPath,
      icon: const Icon(Icons.approval),
      label: 'Leave',
    ),
    BottomNavigationBarRoute(
      initialLocation: PAGES.account.screenPath,
      icon: const Icon(Icons.account_box_rounded),
      label: 'Account',
    ),
  ];
  final managerTabs = [
    BottomNavigationBarRoute(
      initialLocation: PAGES.leave.screenPath,
      icon: const Icon(Icons.dashboard),
      label: 'Leave',
    ),
    BottomNavigationBarRoute(
      initialLocation: PAGES.request.screenPath,
      icon: const Icon(Icons.approval),
      label: 'Request',
    ),
    BottomNavigationBarRoute(
      initialLocation: PAGES.account.screenPath,
      icon: const Icon(Icons.account_box_rounded),
      label: 'Account',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen,
      bottomNavigationBar: _buildBottomNavigation(
          context, managerTabs), //Condition here for manager and employee
    );
  }
}

BlocBuilder<RoutesCubit, RoutesCubitState> _buildBottomNavigation(
        mContext, List<BottomNavigationBarRoute> tabs) =>
    BlocBuilder<RoutesCubit, RoutesCubitState>(
      buildWhen: (previous, current) => previous.index != current.index,
      builder: (context, state) {
        return BottomNavigationBar(
          onTap: (value) {
            if (state.index != value) {
              context.read<RoutesCubit>().managerNavBarItem(
                  value); //Condition here for manager and employee
              context.go(tabs[value].initialLocation);
            }
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          backgroundColor: primaryBlue,
          unselectedItemColor: Colors.blueAccent[100],
          selectedIconTheme: IconThemeData(
            color: Colors.white,
            size: ((IconTheme.of(mContext).size)! * 1.3),
          ),
          items: tabs,
          currentIndex: state.index,
          type: BottomNavigationBarType.fixed,
        );
      },
    );
