// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/CustomAppBar.dart';
import 'package:hr_genie/Components/RequestListTab.dart';
import 'package:hr_genie/Components/ShimmerLoading.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/RoutesCubit/RoutesCubit.dart';
import 'package:hr_genie/Controller/Cubit/RoutesCubit/RoutesState.dart';
import 'package:hr_genie/Routes/RoutesUtils.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutesCubit, RoutesCubitState>(
      builder: (context, state) {
        if (state.status == RouteStatus.initial) {
          return const SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(50),
                  child: CustomAppBar(title: 'Leave Request')),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultTabController(
                    length: 3,
                    child: Expanded(
                      child: Column(
                        children: [
                          TabBar(
                            enableFeedback: true,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorColor: primaryLightBlue,
                            unselectedLabelColor: instructionTextColor,
                            labelColor: Colors.white,
                            labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
                            // ignore: prefer_const_literals_to_create_immutables
                            tabs: [
                              Tab(
                                text: "Pending",
                              ),
                              Tab(
                                text: "Approved",
                              ),
                              Tab(
                                text: "Rejected",
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                //First index(TABS)
                                RequestListTab(
                                  applicationStatus: 'pending',
                                ),
                                RequestListTab(
                                  applicationStatus: 'approved',
                                ),
                                RequestListTab(
                                  applicationStatus: 'rejected',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state.status == RouteStatus.loadingRequestDetails) {
          return ShimmerLoading(screenName: PAGES.requestDetails.screenName);
        } else if (state.status == RouteStatus.error) {
          return Center(
            child: Text("ERROR: ${state.status}"),
          );
        } else {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Error"), CircularProgressIndicator()],
            ),
          );
        }
      },
    );
  }
}
