// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/CustomAppBar.dart';
import 'package:hr_genie/Components/LeaveTabs.dart';
import 'package:hr_genie/Components/NameCard.dart';
import 'package:hr_genie/Components/ShimmerLoading.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Constants/PrintColor.dart';
import 'package:hr_genie/Controller/Cubit/RoutesCubit/RoutesCubit.dart';
import 'package:hr_genie/Controller/Cubit/RoutesCubit/RoutesState.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';

class LeavePage extends StatelessWidget {
  LeavePage({super.key});

  bool connected = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutesCubit, RoutesCubitState>(
      builder: (context, state) {
        printYellow("State: ${state.status}");

        if (state.status == RouteStatus.initial) {
          return SafeArea(
            child: Scaffold(
              appBar: const PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: CustomAppBar(
                  showLogo: true,
                  title: 'HR GENIE',
                ),
              ),
              floatingActionButton: ElevatedButton(
                onPressed: () {
                  context.read<RoutesCubit>().goToApplyLeave();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  disabledBackgroundColor: disabledButtonColor,
                  backgroundColor: primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Apply Leave",
                  style: TextStyle(color: globalTextColor),
                ),
              ),
              body: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ProfileCard(),
                  // RequestCountCard(),
                  LeaveTabs(),
                ],
              ),
            ),
          );
        } else if (state.status == RouteStatus.loadingLeavePage) {
          return Center(
            child: ShimmerLoading(
              screenName: PAGES.leave.screenName,
            ),
          );
        } else if (state.status == RouteStatus.loadingLeaveApplication) {
          return Center(
            child: ShimmerLoading(
              screenName: PAGES.leaveApp.screenName,
            ),
          );
        } else if (state.status == RouteStatus.loadingLeaveDetails) {
          return Center(
            child: ShimmerLoading(
              screenName: PAGES.leaveDetails.screenName,
            ),
          );
        } else if (state.status == RouteStatus.error) {
          return Center(
            child: Text("ERROR: ${state.status}"),
          );
        }

        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Error"), CircularProgressIndicator()],
          ),
        );
      },
    );
  }
}
