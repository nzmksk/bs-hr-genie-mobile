// ignore_for_file: use_build_context_synchronously

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/CustomListTile.dart';
import 'package:hr_genie/Components/CustomSnackBar.dart';
import 'package:hr_genie/Components/ShimmerLoading.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/ApiServiceCubit.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/AprServiceState.dart';
import 'package:hr_genie/Controller/Cubit/AuthCubit/AuthCubit.dart';
import 'package:hr_genie/Controller/Cubit/RoutesCubit/RoutesCubit.dart';
import 'package:hr_genie/Controller/Services/CachedStation.dart';
import 'package:hr_genie/Controller/Services/checkLeaveType.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';
import 'package:hr_genie/View/DisconnectedServer.dart';
import 'package:hr_genie/View/EmptyMyLeave.dart';
import 'package:hr_genie/View/NoInternetPage.dart';
import 'package:intl/intl.dart';

class LeaveHistory extends StatefulWidget {
  const LeaveHistory({super.key});

  @override
  State<LeaveHistory> createState() => _LeaveHistoryState();
}

class _LeaveHistoryState extends State<LeaveHistory> {
  bool connected = true;
  @override
  void initState() {
    super.initState();
    getMyLeaveList(context);
    checkInternet();
  }

  Future<void> getMyLeaveList(BuildContext context) async {
    final accessToken = await CacheStore().getCache('access_token');
    if (accessToken != null) {
      context.read<ApiServiceCubit>().getMyLeaves(accessToken);
    }
  }

  Future<void> checkInternet() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        connected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!connected) {
      return const NoInternetPage();
    }
    return BlocConsumer<ApiServiceCubit, ApiServiceState>(
      listener: (context, state) {
        if (state.status == ApiServiceStatus.failed) {
          showCustomSnackBar(context, state.errorMsg, Colors.red);
        } else if (state.status == ApiServiceStatus.success) {
          // showCustomSnackBar(
          //     context, "Successfully fetch", Colors.green.shade800);
        }
      },
      builder: (context, state) {
        if (state.status == ApiServiceStatus.loading) {
          return ShimmerLoading(screenName: PAGES.request.screenName);
        } else if (state.status == ApiServiceStatus.failed) {
          return Center(
              child: DisconnectedServer(errorMsg: state.errorMsg ?? ''));
        }
        if (state.myLeaveList == null || state.myLeaveList!.length == 0) {
          return const EmptyMyLeave();
        } else {
          state.myLeaveList!.sort((a, b) {
            //sorting in ascending order
            return DateTime.parse(b!.createdAt!)
                .compareTo(DateTime.parse(a!.createdAt!));
          });

          return RefreshIndicator(
            onRefresh: () async {
              final accessToken = await CacheStore().getCache('access_token');
              await context.read<ApiServiceCubit>().getLeaveQuota(accessToken!);
              await context.read<ApiServiceCubit>().getMyLeaves(accessToken);

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
                      child: Icon(
                        checkLeaveTypeTitle(
                            state.myLeaveList?[index]!.applicationStatus!),
                        color: globalTextColor,
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
            : status == "pending"
                ? Colors.amber
                : Colors.grey;
  }
}
