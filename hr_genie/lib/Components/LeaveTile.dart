import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_genie/Components/CustomListTile.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Model/LeaveModel.dart';
import 'package:intl/intl.dart';

class LeaveTile extends StatelessWidget {
  final int index;
  final Color tileColor;
  final Function()? onTap;
  const LeaveTile(
      {super.key,
      required this.leaveList,
      required this.index,
      required this.tileColor,
      this.onTap});

  final List<Leave> leaveList;

  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      onTap: onTap,
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      leading: CircleAvatar(
        backgroundColor: tileColor,
        child: Text(
          leaveList[index].employeeId[0],
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      title: Text(
        leaveList[index].employeeId,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        " ${DateFormat.yMMMd('en_US').format(leaveList[index].startDate)} - ${DateFormat.yMMMd('en_US').format(leaveList[index].endDate)}",
        style: const TextStyle(fontSize: 12),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: globalTextColor,
      ),
      color: cardColor,
    );
  }
}
