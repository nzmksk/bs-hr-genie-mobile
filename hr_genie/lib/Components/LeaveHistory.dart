import 'package:flutter/material.dart';
import 'package:hr_genie/Components/CustomListTile.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Model/LeaveModel.dart';
import 'package:intl/intl.dart';

class LeaveHistory extends StatefulWidget {
  const LeaveHistory({super.key});

  @override
  State<LeaveHistory> createState() => _LeaveHistoryState();
}

class _LeaveHistoryState extends State<LeaveHistory> {
  final List<Leave> leave = [
    Leave(
        startDate: DateTime.parse('1969-07-20 20:18:04Z'),
        endDate: DateTime(2023, 6, 30, 15, 30),
        leaveTypeId: "AL",
        leaveId: "AL003",
        reason: "Going on Vacation",
        applicationStatus: "Rejected",
        attachment: 'Hf830nen',
        employeeId: 'IT302',
        approvedRejectedBy: 'HRS230'),
    Leave(
        startDate: DateTime.parse('2022-07-20 20:18:04Z'),
        endDate: DateTime(2023, 7, 2, 15, 30),
        leaveTypeId: "EL",
        leaveId: "AL003",
        reason: "Going on Vacation",
        applicationStatus: "Approved",
        attachment: 'Hf830nen',
        employeeId: 'IT302',
        approvedRejectedBy: 'HRS230'),
    Leave(
        startDate: DateTime.parse('1969-07-20 20:18:04Z'),
        endDate: DateTime(2023, 7, 2, 15, 30),
        leaveTypeId: "PL",
        leaveId: "AL003",
        reason: "Going on Vacation",
        applicationStatus: "Pending",
        attachment: 'Hf830nen',
        employeeId: 'IT302',
        approvedRejectedBy: 'HRS230'),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: leave.length,
        itemBuilder: (context, index) {
          String dateStart =
              DateFormat.yMMMd('en-US').format(leave[index].startDate);

          return CustomListTile(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            color: cardColor,
            leading: CircleAvatar(
              backgroundColor: checkColor(index),
              child: Text(
                leave[index].leaveTypeId,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(checkLeaveType(leave[index].leaveTypeId)),
            subtitle: Text(
              dateStart,
              style: const TextStyle(color: subtitleTextColor),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: globalTextColor,
              ),
              onPressed: () {},
            ),
            // trailing: Text(leave[index].startDate),
          );
        });
  }

  MaterialColor checkColor(int index) {
    return leave[index].applicationStatus == "Rejected"
        ? Colors.red
        : leave[index].applicationStatus == "Approved"
            ? Colors.green
            : Colors.amber;
  }

  String checkLeaveType(String leaveId) {
    switch (leaveId) {
      case "AL":
        return "Annual Leave";
      case "EL":
        return "Emergency Leave";
      case "PL":
        return "Parental Leave";
      case "ML":
        return "Medical Leave";
      case "UL":
        return "Unpaid Leave";
      default:
        return 'Unrecognized';
    }
  }
}
