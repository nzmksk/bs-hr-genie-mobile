class Leave {
  Leave({
    required this.firstName,
    required this.lastName,
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
  String? firstName;
  String? lastName;
  String? leaveId;
  String? employeeId;
  int? leaveTypeId;
  String? startDate;
  String? endDate;
  String? durationType;
  String? durationLength;
  String? reason;
  String? attachment;
  String? applicationStatus;
  String? createdAt;
  String? approvedRejectedBy;
  String? rejectReason;

  Leave.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    leaveId = json['leaveId'];
    employeeId = json['employeeId'];
    leaveTypeId = json['leaveTypeId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    durationType = json['durationType'];
    durationLength = json['durationLength'];
    reason = json['reason'];
    attachment = json['attachment'];
    applicationStatus = json['applicationStatus'];
    createdAt = json['createdAt'];
    approvedRejectedBy = json['approvedRejectedBy'];
    rejectReason = json['rejectReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = new Map<String, dynamic>();
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['leaveId'] = leaveId;
    _data['employeeId'] = employeeId;
    _data['leaveTypeId'] = leaveTypeId;
    _data['startDate'] = startDate;
    _data['endDate'] = endDate;
    _data['durationType'] = durationType;
    _data['durationLength'] = durationLength;
    _data['reason'] = reason;
    _data['attachment'] = attachment;
    _data['applicationStatus'] = applicationStatus;
    _data['createdAt'] = createdAt;
    _data['approvedRejectedBy'] = approvedRejectedBy;
    _data['rejectReason'] = rejectReason;
    return _data;
  }
}
