import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/LeaveTile.dart';
import 'package:hr_genie/Components/ShimmerLoading.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/ApiServiceCubit.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/AprServiceState.dart';
import 'package:hr_genie/Controller/Cubit/RoutesCubit/RoutesCubit.dart';
import 'package:hr_genie/Controller/Services/CachedStation.dart';
import 'package:hr_genie/Model/EmployeeModel.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';
import 'package:hr_genie/View/MyLeaveEmpty.dart';

import '../Model/LeaveModel.dart';

class RequestListTab extends StatelessWidget {
  final String applicationStatus;
  const RequestListTab({super.key, required this.applicationStatus});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiServiceCubit, ApiServiceState>(
      builder: (context, state) {
        if (state.pendingList == null) {
          bool isLoad = false;
          Timer.periodic(const Duration(seconds: 2), (timer) {
            isLoad = true;
          });

          return isLoad
              ? const MyLeaveEmpty()
              : ShimmerLoading(screenName: PAGES.request.screenName);
        } else if (state.pendingList != null) {
          if (applicationStatus == 'pending') {
            return RefreshIndicator(
              onRefresh: () async {},
              child: ListView.builder(
                  itemCount: state.pendingList!.length,
                  itemBuilder: (context, index) => LeaveTile(
                        leaveList: state.pendingList!,
                        index: index,
                        onTap: () => context
                            .read<RoutesCubit>()
                            .goToRequestDetail(state.pendingList![index]!),
                      )),
            );
          } else if (applicationStatus == 'approved') {
            return RefreshIndicator(
              onRefresh: () async {},
              child: ListView.builder(
                  itemCount: state.approvedList!.length,
                  itemBuilder: (context, index) => LeaveTile(
                        leaveList: state.approvedList!,
                        index: index,
                        onTap: () => context
                            .read<RoutesCubit>()
                            .goToRequestDetail(state.approvedList![index]!),
                      )),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {},
              child: ListView.builder(
                  itemCount: state.rejectedList!.length,
                  itemBuilder: (context, index) => LeaveTile(
                        leaveList: state.rejectedList!,
                        index: index,
                        onTap: () => context
                            .read<RoutesCubit>()
                            .goToRequestDetail(state.rejectedList![index]!),
                      )),
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

//   List<Leave?>? pendingList(List<Leave?>? fullList){
// fullList.where((element) => element.applicationStatus == 'pending').toList()
//   }
}
