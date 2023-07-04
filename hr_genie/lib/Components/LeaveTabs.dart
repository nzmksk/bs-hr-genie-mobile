import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_genie/Components/LeaveCalendar.dart';

import 'LeaveHistory.dart';

class LeaveTabs extends StatelessWidget {
  const LeaveTabs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Expanded(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: TabBar(
                indicatorColor: Colors.red,
                unselectedLabelColor: Colors.black,
                labelColor: Colors.white,
                labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.indigo),
                tabs: const [
                  Tab(
                    text: "History",
                  ),
                  Tab(
                    text: "Calendar",
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const TabBarView(
                  children: [
                    LeaveHistory(),
                    LeaveCalendar(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
