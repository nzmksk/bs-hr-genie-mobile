import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String checkLeaveType(String? leaveId) {
  switch (leaveId) {
    case "1":
      return "Annual Leave";
    case "2":
      return "Medical Leave";
    case "3":
      return "Parental Leave";
    case "4":
      return "Emergency Leave";
    case "5":
      return "Unpaid Leave";
    default:
      return 'Unrecognized';
  }
}

IconData checkLeaveTypeTitle(String? status) {
  switch (status) {
    case "pending":
      return Icons.timer_outlined;
    case "approved":
      return Icons.check;
    case "rejected":
      return Icons.close;
    case "cancelled":
      return Icons.do_not_disturb_alt_sharp;
    default:
      return Icons.question_mark;
  }
}

String truncatNum(String? durationLength) {
  var duration = num.parse(durationLength!);
  if (duration == duration.roundToDouble()) {
    duration = duration.round();
    return '$duration';
  } else {
    return '${duration.toStringAsFixed(1)}';
  }
}

String capitalize(String? value) {
  return "${value![0].toUpperCase()}${value.substring(1).toLowerCase()}";
}
