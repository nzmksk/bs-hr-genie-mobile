import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hr_genie/Components/CustomListTile.dart';
import 'package:hr_genie/Constants/Color.dart';
import 'package:hr_genie/Controller/Services/checkLeaveType.dart';
import 'package:hr_genie/Model/LeaveModel.dart';
import 'package:intl/intl.dart';

class LeaveTile extends StatelessWidget {
  final int index;

  final Function()? onTap;
  const LeaveTile(
      {super.key, required this.leaveList, required this.index, this.onTap});

  final List<Leave?>? leaveList;
  @override
  Widget build(BuildContext context) {
    return CustomListTile(
      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      onTap: onTap,
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      leading: CircleAvatar(
        backgroundColor:
            checkColor(index, leaveList?[index]?.applicationStatus ?? ""),
        child: Text(
          checkLeaveTypeTitle(leaveList?[index]?.leaveTypeId.toString()),
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      title: Text(
        leaveList?[index]!.employeeId ?? "",
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        // '',
        " ${DateFormat.yMMMd('en_US').format(DateTime.parse(leaveList![index]!.startDate!))} - ${DateFormat.yMMMd('en_US').format(DateTime.parse(leaveList![index]!.endDate!))}",
        style: const TextStyle(fontSize: 12),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: globalTextColor,
      ),
      color: cardColor,
    );
  }

  MaterialColor checkColor(int index, String status) {
    return status == "rejected"
        ? Colors.red
        : status == "approved"
            ? Colors.green
            : Colors.amber;
  }
}
