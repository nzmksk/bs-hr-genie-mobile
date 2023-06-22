class LeaveCategory {
  int? leaveTypeId;
  String? leaveTypeName;

  LeaveCategory({this.leaveTypeId, this.leaveTypeName});

  LeaveCategory.fromJson(Map<String, dynamic> json) {
    leaveTypeId = json['leave_type_id'];
    leaveTypeName = json['leave_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leave_type_id'] = this.leaveTypeId;
    data['leave_type_name'] = this.leaveTypeName;
    return data;
  }
}
