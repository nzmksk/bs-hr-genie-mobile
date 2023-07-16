import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/CustomSnackBar.dart';
import 'package:hr_genie/Components/LeaveTile.dart';
import 'package:hr_genie/Components/ShimmerLoading.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/ApiServiceCubit.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/AprServiceState.dart';
import 'package:hr_genie/Controller/Cubit/RoutesCubit/RoutesCubit.dart';
import 'package:hr_genie/Controller/Services/CachedStation.dart';
import 'package:hr_genie/Model/EmployeeModel.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';
import 'package:hr_genie/View/DisconnectedServer.dart';
import 'package:hr_genie/View/EmptyMyLeave.dart';

import '../Model/LeaveModel.dart';

class RequestListTab extends StatefulWidget {
  final String applicationStatus;
  const RequestListTab({super.key, required this.applicationStatus});

  @override
  State<RequestListTab> createState() => _RequestListTabState();
}

class _RequestListTabState extends State<RequestListTab> {
  @override
  void initState() {
    // TODO: Refresh the Request List from API
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiServiceCubit, ApiServiceState>(
      builder: (context, state) {
        print("STATUS: ${state.status}");
        if (state.status == ApiServiceStatus.loading) {
          return ShimmerLoading(screenName: PAGES.request.screenName);
        } else if (state.status == ApiServiceStatus.failed) {
          return Center(
              child: DisconnectedServer(errorMsg: state.errorMsg ?? ''));
        } else if (state.allRequestList == null) {
          return const EmptyMyLeave();
        } else if (state.allRequestList != null ||
            state.status == ApiServiceStatus.success) {
          return requestListView(state);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  RefreshIndicator requestListView(ApiServiceState state) {
    if (widget.applicationStatus == 'pending') {
      return RefreshIndicator(
        onRefresh: () async {
          showCustomSnackBar(context, 'Refreshed', cardColor);
        },
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
    } else if (widget.applicationStatus == 'approved') {
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
  }
}
