import 'package:flutter/material.dart';
import 'package:hr_genie/model/LeaveModel.dart';
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
        duration: 2.5,
        leaveTypeId: "AL",
        leaveId: "AL003",
        reason: "Going on Vacation",
        applicationStatus: "Pending",
        attachment: 'Hf830nen',
        employeeId: 'IT302',
        approvedRejectedBy: 'HRS230'),
    Leave(
        startDate: DateTime.parse('2022-07-20 20:18:04Z'),
        duration: 2.5,
        leaveTypeId: "AL",
        leaveId: "AL003",
        reason: "Going on Vacation",
        applicationStatus: "Pending",
        attachment: 'Hf830nen',
        employeeId: 'IT302',
        approvedRejectedBy: 'HRS230'),
    Leave(
        startDate: DateTime.parse('1969-07-20 20:18:04Z'),
        duration: 2.5,
        leaveTypeId: "AL",
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
              DateFormat('yyyy-MM-dd HH:mm:ss').format(leave[index].startDate);

          return ListTile(
            title: const Text("Annual Leave"),
            subtitle: Text(leave[index].reason),
            isThreeLine: true,
            trailing: Text(dateStart),
            // trailing: Text(leave[index].startDate),
          );
        });
  }
}
