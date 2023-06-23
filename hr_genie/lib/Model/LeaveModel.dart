class Leave {
  Leave({
    required this.leaveId,
    required this.employeeId,
    required this.leaveTypeId,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.attachment,
    required this.applicationStatus,
    required this.approvedRejectedBy,
  });
  late final String leaveId;
  late final String employeeId;
  late final String leaveTypeId;
  late final DateTime startDate;
  late final DateTime endDate;
  late final String reason;
  late final String attachment;
  late final String applicationStatus;
  late final String approvedRejectedBy;

  Leave.fromJson(Map<String, dynamic> json) {
    leaveId = json['leave_id'];
    employeeId = json['employee_id'];
    leaveTypeId = json['leave_type_id'];
    startDate = json['start_date'];
    endDate = json['duration'];
    reason = json['reason'];
    attachment = json['attachment'];
    applicationStatus = json['application_status'];
    approvedRejectedBy = json['approved_rejected_by'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['leave_id'] = leaveId;
    _data['employee_id'] = employeeId;
    _data['leave_type_id'] = leaveTypeId;
    _data['start_date'] = startDate;
    _data['duration'] = endDate;
    _data['reason'] = reason;
    _data['attachment'] = attachment;
    _data['application_status'] = applicationStatus;
    _data['approved_rejected_by'] = approvedRejectedBy;
    return _data;
  }
}
