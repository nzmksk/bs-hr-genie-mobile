import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hr_genie/Components/BottomNavBarWithRoutes.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/ApiServiceCubit.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/AprServiceState.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthCubit.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthState.dart';
import 'package:hr_genie/Controller/Cubit/RoutesCubit/RoutesCubit.dart';
import 'package:hr_genie/Controller/Cubit/RoutesCubit/RoutesState.dart';
import 'package:hr_genie/Controller/Services/CachedStation.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';
import 'package:badges/badges.dart' as badges;

import '../Model/EmployeeModel.dart';

class HomePage extends StatefulWidget {
  final Widget screen;
  String? isManager = "false";
  HomePage({
    super.key,
    required this.screen,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      icon: const Icon(Icons.home),
      label: 'Leave',
    ),
    BottomNavigationBarRoute(
      initialLocation: PAGES.request.screenPath,
      icon: const badges.Badge(
          badgeAnimation: badges.BadgeAnimation.fade(),
          badgeContent: BadgesPending(),
          child: Icon(Icons.calendar_month)),
      label: 'Request',
    ),
    BottomNavigationBarRoute(
      initialLocation: PAGES.account.screenPath,
      icon: const Icon(Icons.person),
      label: 'Account',
    ),
  ];
  @override
  void initState() {
    super.initState();
    getRequestLeaveList(context);
  }

  Future<void> getRequestLeaveList(BuildContext context) async {
    final accessToken = await CacheStore().getCache('access_token');
    final userDataRes = await CacheStore().getCache('user_data');

    final jsonData = json.decode(userDataRes!);
    final Map<String, dynamic> data = jsonData['data'];
    final employee = Employee.fromJson(data);
    final isManager = await getUser();

    if (accessToken != null && isManager) {
      context
          .read<ApiServiceCubit>()
          .getRequestLeaves(accessToken, employee.departmentId);
    }
  }

  Future<bool> getUser() async {
    final userDataRes = await CacheStore().getCache('user_data');
    if (userDataRes != null) {
      final jsonData = json.decode(userDataRes);
      final Map<String, dynamic> data = jsonData['data'];
      final employee = Employee.fromJson(data);
      final bool isManager = employee.employeeRole == 'manager';
      return isManager;
    } else {
      print("NotLogged: User Data is null");
      return false;
    }
  }
  // Future<void> checkRole() async {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        print("is Manager: ${state.isManager}");

        return Scaffold(
            body: widget.screen,
            bottomNavigationBar: state.isManager!
                ? _buildManagerBottomNavigation(context, managerTabs)
                : _buildBottomNavigation(context, tabs)
            //Condition here for manager and employee
            );
      },
    );
  }
}

class BadgesPending extends StatelessWidget {
  const BadgesPending({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiServiceCubit, ApiServiceState>(
      builder: (context, state) {
        if (state.pendingList == null) {
          return const Visibility(visible: false, child: Text(""));
        } else {
          return Text(state.pendingList!
              .where((element) => element!.applicationStatus == 'pending')
              .length
              .toString());
        }
      },
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
              context.read<RoutesCubit>().employeeNavBarItem(value);
              //Condition here for manager and employee
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

BlocBuilder<RoutesCubit, RoutesCubitState> _buildManagerBottomNavigation(
        mContext, List<BottomNavigationBarRoute> tabs) =>
    BlocBuilder<RoutesCubit, RoutesCubitState>(
      buildWhen: (previous, current) => previous.index != current.index,
      builder: (context, state) {
        return BottomNavigationBar(
          onTap: (value) {
            if (state.index != value) {
              context.read<RoutesCubit>().managerNavBarItem(value);
              //Condition here for manager and employee
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
