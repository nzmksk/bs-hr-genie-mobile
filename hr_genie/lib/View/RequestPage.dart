import 'package:flutter/material.dart';
import 'package:hr_genie/Components/CustomListTile.dart';
import 'package:hr_genie/Components/PendingTab.dart';
import 'package:hr_genie/Model/LeaveModel.dart';
import 'package:intl/intl.dart';

class RequestPage extends StatelessWidget {
  RequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Request"),
          DefaultTabController(
            length: 3,
            child: Expanded(
              child: Column(
                children: [
                  const TabBar(
                    indicatorColor: Colors.blue,
                    unselectedLabelColor: Colors.blue,
                    labelColor: Colors.blue,
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
                        Text("Approved"),
                        //tabs 3
                        Text("Rejected"),
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
