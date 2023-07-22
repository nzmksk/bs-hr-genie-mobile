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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['leaveType'] = leaveType;
    data['quota'] = quota;
    return data;
  }
}
