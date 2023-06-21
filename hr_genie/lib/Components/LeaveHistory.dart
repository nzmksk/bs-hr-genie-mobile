import 'package:flutter/material.dart';
import 'package:hr_genie/model/LeaveModel.dart';

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
        attachment: '',
        employeeId: '',
        approvedRejectedBy: ''),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: leave.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: const Text("Annual Leave"),
            subtitle: Text(leave[index].reason.toString()),
          );
        });
  }
}
