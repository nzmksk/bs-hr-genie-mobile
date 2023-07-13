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
