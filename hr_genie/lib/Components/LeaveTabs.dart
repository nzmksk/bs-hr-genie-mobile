import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_genie/Components/LeaveCalendar.dart';
import 'package:hr_genie/Constants/Color.dart';

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
            Container(
              margin: const EdgeInsets.fromLTRB(12, 5, 12, 0),
              child: Stack(
                fit: StackFit.passthrough,
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: cardColor,
                    ),
                  ),
                  TabBar(
                    dividerColor: Colors.red,
                    unselectedLabelColor: subtitleTextColor,
                    labelColor: Colors.white,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: primaryBlue),
                    tabs: const [
                      Tab(
                        text: "History",
                      ),
                      Tab(
                        text: "Calendar",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
