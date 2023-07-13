class Leave {
  Leave({
    required this.leaveId,
    required this.employeeId,
    required this.leaveTypeId,
    required this.startDate,
    required this.endDate,
    required this.durationType,
    required this.durationLength,
    required this.reason,
    required this.attachment,
    required this.applicationStatus,
    required this.createdAt,
    required this.approvedRejectedBy,
    required this.rejectReason,
  });
  late final String leaveId;
  late final String employeeId;
  late final String leaveTypeId;
  late final DateTime startDate;
  late final DateTime endDate;
  late final String durationType;
  late final num durationLength;
  late final String reason;
  late final String attachment;
  late final String applicationStatus;
  late final DateTime createdAt;
  late final String approvedRejectedBy;
  late final String rejectReason;

  Leave.fromJson(Map<String, dynamic> json) {
    leaveId = json['leave_id'];
    employeeId = json['employee_id'];
    leaveTypeId = json['leave_type_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    durationType = json['duration_type'];
    durationLength = json['duration_length'];
    reason = json['reason'];
    attachment = json['attachment'];
    applicationStatus = json['application_status'];
    createdAt = json['created_at'];
    approvedRejectedBy = json['approved_rejected_by'];
    rejectReason = json['reject_reason'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['leave_id'] = leaveId;
    _data['employee_id'] = employeeId;
    _data['leave_type_id'] = leaveTypeId;
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    _data['duration_type'] = durationType;
    _data['duration_length'] = durationLength;
    _data['reason'] = reason;
    _data['attachment'] = attachment;
    _data['application_status'] = applicationStatus;
    _data['created_at'] = createdAt;
    _data['approved_rejected_by'] = approvedRejectedBy;
    _data['reject_reason'] = rejectReason;
    return _data;
  }
}
