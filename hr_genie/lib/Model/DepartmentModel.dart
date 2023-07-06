class Department {
  String? departmentId;
  String? departmentName;

  Department({this.departmentId, this.departmentName});

  Department.fromJson(Map<String, dynamic> json) {
    departmentId = json['department_id'];
    departmentName = json['department_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'department_id': departmentId,
      'department_name': departmentName
    };
    // data['department_id'] = this.departmentId;
    // data['department_name'] = this.departmentName;
    return data;
  }
}
