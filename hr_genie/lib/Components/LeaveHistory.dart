import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr_genie/Components/CustomListTile.dart';
import 'package:hr_genie/Constants/ApplicationStatus.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Cubit/RoutesCubit/RoutesCubit.dart';
import 'package:hr_genie/Controller/Services/LeaveCategory.dart';
import 'package:hr_genie/Controller/Services/checkLeaveType.dart';
import 'package:hr_genie/Model/LeaveCategoryModel.dart';
import 'package:hr_genie/Model/LeaveModel.dart';
import 'package:intl/intl.dart';

class LeaveHistory extends StatefulWidget {
  const LeaveHistory({super.key});

  @override
  State<LeaveHistory> createState() => _LeaveHistoryState();
}

class _LeaveHistoryState extends State<LeaveHistory> {
  List<Leave> leaveList = List.generate(10, (index) {
    final faker = Faker();
    List<String> leave = [
      LEAVES.annual.id.leaveTypeId!,
      LEAVES.emergency.id.leaveTypeId!,
      LEAVES.parental.id.leaveTypeId!,
      LEAVES.medical.id.leaveTypeId!,
      LEAVES.unpaid.id.leaveTypeId!,
    ];
    List<String> status = [
      AppStatus.pending.string,
      AppStatus.approved.string,
      AppStatus.rejected.string,
    ];
    final randomIndex = Random().nextInt(leave.length);
    final randomIndex2 = Random().nextInt(status.length);
    DateTime currentDate = DateTime.now();

    final DateTime startDate =
        faker.date.dateTime(minYear: 2023, maxYear: 2024);
    return Leave(
      leaveId: faker.guid.guid(),
      employeeId: faker.person.name(),
      leaveTypeId: leave[randomIndex],
      startDate: startDate,
      endDate: startDate.add(Duration(days: Random().nextInt(10))),
      reason: faker.lorem.sentence(),
      attachment: faker.lorem.word(),
      applicationStatus: status[randomIndex2],
      approvedRejectedBy: faker.person.name(),
      createdAt: faker.date.dateTime(maxYear: currentDate.year),
      durationType: '',
      durationLength: 3,
      rejectReason: '',
    );
  });
  @override
  Widget build(BuildContext context) {
    leaveList.sort((a, b) {
      return b.createdAt.compareTo(a.createdAt);
    });

    return ListView.builder(
        itemCount: leaveList.length,
        itemBuilder: (context, index) {
          String dateStart =
              DateFormat.yMMMd('en-US').format(leaveList[index].startDate);

          return CustomListTile(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            color: cardColor,
            leading: CircleAvatar(
              backgroundColor: checkColor(index),
              child: Text(
                leaveList[index].leaveTypeId,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(checkLeaveType(leaveList[index].leaveTypeId)),
            subtitle: Text(
              dateStart,
              style: const TextStyle(color: subtitleTextColor),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: globalTextColor,
            ),
            onTap: () =>
                context.read<RoutesCubit>().goToLeaveDetail(leaveList[index]),
            // trailing: Text(leave[index].startDate),
          );
        });
  }

  MaterialColor checkColor(int index) {
    return leaveList[index].applicationStatus == "Rejected"
        ? Colors.red
        : leaveList[index].applicationStatus == "Approved"
            ? Colors.green
            : Colors.amber;
  }
}
