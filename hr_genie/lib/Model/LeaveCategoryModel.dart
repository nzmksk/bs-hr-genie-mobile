class LeaveCategory {
  String? leaveTypeId;
  String? leaveTitle;

  LeaveCategory({this.leaveTypeId, this.leaveTitle});

  LeaveCategory.fromJson(Map<String, dynamic> json) {
    leaveTypeId = json['leave_type_id'];
    leaveTitle = json['leave_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['leave_type_id'] = leaveTypeId;
    data['leave_type_name'] = leaveTitle;
    return data;
  }
}
