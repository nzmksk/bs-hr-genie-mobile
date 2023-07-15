// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hr_genie/Components/RequestListTab.dart';
import 'package:hr_genie/Constants/Color.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Leave Approval"),
          ),
          body: const Column(
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
          )),
    );
  }
}
