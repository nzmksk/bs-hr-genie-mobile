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

String checkLeaveTypeTitle(String? leaveId) {
  switch (leaveId) {
    case "1":
      return "AL";
    case "2":
      return "EL";
    case "3":
      return "PL";
    case "4":
      return "ML";
    case "5":
      return "UL";
    default:
      return '??';
  }
}

String truncatNum(String? durationLength) {
  var duration = num.parse(durationLength!);
  if (duration > 0.5) {
    duration = duration.truncate();
    return '$duration';
  } else {
    return '$duration';
  }
}

String capitalize(String? value) {
  return "${value![0].toUpperCase()}${value.substring(1).toLowerCase()}";
}
