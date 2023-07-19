class LeaveQuota {
  String? leaveType;
  String? quota;
  String? usedLeave;

  LeaveQuota({this.leaveType, this.quota});

  LeaveQuota.fromJson(Map<String, dynamic> json) {
    leaveType = json['leaveType'];
    quota = json['quota'];
    usedLeave = json['usedLeave'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leaveType'] = this.leaveType;
    data['quota'] = this.quota;
    return data;
  }
}
