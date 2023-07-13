import 'package:flutter/material.dart';
import 'package:hr_genie/Components/ApprovedTab.dart';
import 'package:hr_genie/Components/PendingTab.dart';
import 'package:hr_genie/Components/RejectedTab.dart';
import 'package:hr_genie/Constants/Color.dart';

class RequestPage extends StatelessWidget {
  RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Leave Approval"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTabController(
                length: 3,
                child: Expanded(
                  child: Column(
                    children: [
                      const TabBar(
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
                      const SizedBox(
                        height: 5.0,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            //First index(TABS)
                            PendingTab(),
                            //tabs 2
                            ApprovedTab(),
                            //tabs 3
                            RejectedTab(),
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
