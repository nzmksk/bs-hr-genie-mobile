class LeaveQuota {
  String? employeeId;
  int? leaveTypeId;
  int? quota;

  LeaveQuota({this.employeeId, this.leaveTypeId, this.quota});

  LeaveQuota.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    leaveTypeId = json['leave_type_id'];
    quota = json['quota'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    data['leave_type_id'] = this.leaveTypeId;
    data['quota'] = this.quota;
    return data;
  }
}
