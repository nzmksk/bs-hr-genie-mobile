import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hr_genie/Components/botNavBarRoute.dart';
import 'package:hr_genie/routes/app_routes.dart';
import 'package:hr_genie/routes/routes_utils.dart';

import '../cubit/routes_cubit/routes_cubit.dart';

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
      initialLocation: PAGES.account.screenName,
      icon: const Icon(Icons.account_box_rounded),
      label: 'Account',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen,
      bottomNavigationBar: _buildBottomNavigation(context, tabs),
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
              context.read<RoutesCubit>().getNavBarItem(value);
              context.go(tabs[value].initialLocation);
            }
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(
            size: ((IconTheme.of(mContext).size)! * 1.3),
          ),
          items: tabs,
          currentIndex: state.index,
          type: BottomNavigationBarType.fixed,
        );
      },
    );
