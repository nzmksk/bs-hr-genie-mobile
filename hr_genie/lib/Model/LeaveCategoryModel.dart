class LeaveCategory {
  String? leaveTypeId;
  String? leaveTitle;

  LeaveCategory({this.leaveTypeId, this.leaveTitle});

  LeaveCategory.fromJson(Map<String, dynamic> json) {
    leaveTypeId = json['leave_type_id'];
    leaveTitle = json['leave_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leave_type_id'] = this.leaveTypeId;
    data['leave_type_name'] = this.leaveTitle;
    return data;
  }
}
