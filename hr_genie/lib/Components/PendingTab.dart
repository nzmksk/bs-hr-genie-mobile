import 'package:flutter/material.dart';
import 'package:hr_genie/Components/CustomListTile.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:intl/intl.dart';

import '../Model/LeaveModel.dart';

class PendingTab extends StatelessWidget {
  PendingTab({super.key});
  List<Leave> leaveList = [
    Leave(
      leaveId: "leaveId",
      employeeId: "Chuck Norris",
      leaveTypeId: "leaveTypeId",
      startDate: DateTime(2023, 9, 7),
      endDate: DateTime(2023, 9, 7),
      reason: "reason",
      attachment: "attachment",
      applicationStatus: "Rejected",
      approvedRejectedBy: "approvedRejectedBy",
    ),
    Leave(
      leaveId: "leaveId",
      employeeId: "Joe Mama",
      leaveTypeId: "leaveTypeId",
      startDate: DateTime(1993, 7, 7),
      endDate: DateTime(2023, 9, 7),
      reason: "reason",
      attachment: "attachment",
      applicationStatus: "Approved",
      approvedRejectedBy: "approvedRejectedBy",
    ),
    Leave(
      leaveId: "leaveId",
      employeeId: "Joe Mama",
      leaveTypeId: "leaveTypeId",
      startDate: DateTime(1993, 7, 7),
      endDate: DateTime(2023, 9, 7),
      reason: "reason",
      attachment: "attachment",
      applicationStatus: "Pending",
      approvedRejectedBy: "approvedRejectedBy",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: leaveList.length,
              itemBuilder: (context, index) => CustomListTile(
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    leading: CircleAvatar(
                      backgroundColor: Colors.amber,
                      child: Text(
                        leaveList[index].employeeId[0],
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    title: Text(
                      leaveList[index].employeeId,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      " ${DateFormat.yMMMd('en_US').format(leaveList[index].startDate)} - ${DateFormat.yMMMd('en_US').format(leaveList[index].endDate)}",
                      style: TextStyle(fontSize: 12),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    color: cardColor,
                  )),
        )
      ],
    );
  }
}
