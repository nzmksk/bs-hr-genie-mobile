// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/CustomListTile.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/ApiServiceCubit.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/AprServiceState.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthCubit.dart';
import 'package:hr_genie/Controller/Cubit/RoutesCubit/RoutesCubit.dart';
import 'package:hr_genie/Controller/Services/CachedStation.dart';
import 'package:hr_genie/Controller/Services/checkLeaveType.dart';
import 'package:hr_genie/View/MyLeaveEmpty.dart';
import 'package:intl/intl.dart';

class LeaveHistory extends StatefulWidget {
  const LeaveHistory({super.key});

  @override
  State<LeaveHistory> createState() => _LeaveHistoryState();
}

class _LeaveHistoryState extends State<LeaveHistory> {
  @override
  void initState() {
    super.initState();
    getMyLeaveList(context);
  }

  Future<void> getMyLeaveList(BuildContext context) async {
    final accessToken = await CacheStore().getCache('access_token');
    if (accessToken != null) {
      context.read<ApiServiceCubit>().getMyLeaves(accessToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApiServiceCubit, ApiServiceState>(
      builder: (context, state) {
        if (state.myLeaveList == null) {
          return const MyLeaveEmpty();
        } else {
          state.myLeaveList!.sort((a, b) {
            //sorting in ascending order
            return DateTime.parse(a!.createdAt!)
                .compareTo(DateTime.parse(b!.createdAt!));
          });

          return RefreshIndicator(
            onRefresh: () async {
              final accessToken = await CacheStore().getCache('access_token');
              context.read<ApiServiceCubit>().getLeaveQuota(accessToken!);
              context.read<AuthCubit>().fetchUserData();
            },
            child: ListView.builder(
                itemCount: state.myLeaveList?.length,
                itemBuilder: (context, index) {
                  String dateStart = DateFormat.yMMMd('en-US').format(
                      DateTime.parse(state.myLeaveList![index]!.startDate!));

                  return CustomListTile(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    color: cardColor,
                    leading: CircleAvatar(
                      backgroundColor: checkColor(index,
                          state.myLeaveList?[index]!.applicationStatus ?? ""),
                      child: Text(
                        checkLeaveTypeTitle(
                            state.myLeaveList?[index]!.leaveTypeId!.toString()),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(checkLeaveType(
                        (state.myLeaveList?[index]!.leaveTypeId).toString())),
                    subtitle: Text(
                      dateStart,
                      style: const TextStyle(color: subtitleTextColor),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: globalTextColor,
                    ),
                    onTap: () => context
                        .read<RoutesCubit>()
                        .goToLeaveDetail(state.myLeaveList![index]!),
                    // trailing: Text(leave[index].startDate),
                  );
                }),
          );
        }
      },
    );
  }

  MaterialColor checkColor(int index, String status) {
    return status == "rejected"
        ? Colors.red
        : status == "approved"
            ? Colors.green
            : Colors.amber;
  }
}
