class Employee {
  String? employeeId;
  String? departmentId;
  String? employeeRole;
  String? firstName;
  String? lastName;
  String? gender;
  String? email;
  String? hashPassword;
  String? phone;
  String? nric;
  bool? isProbation;
  bool? isMarried;
  String? joinedDate;
  int? tenure;
  int? positionLevel;
  String? createdAt;

  Employee(
      {this.employeeId,
      this.departmentId,
      this.employeeRole,
      this.firstName,
      this.lastName,
      this.gender,
      this.email,
      this.hashPassword,
      this.phone,
      this.nric,
      this.isProbation,
      this.isMarried,
      this.joinedDate,
      this.tenure,
      this.positionLevel,
      this.createdAt});

  Employee.fromJson(Map<String, dynamic> json) {
    employeeId = json['employee_id'];
    departmentId = json['department_id'];
    employeeRole = json['employee_role'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    email = json['email'];
    hashPassword = json['hash_password'];
    phone = json['phone'];
    nric = json['nric'];
    isProbation = json['is_probation'];
    isMarried = json['is_married'];
    joinedDate = json['joined_date'];
    tenure = json['tenure'];
    positionLevel = json['position_level'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employee_id'] = this.employeeId;
    data['department_id'] = this.departmentId;
    data['employee_role'] = this.employeeRole;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['hash_password'] = this.hashPassword;
    data['phone'] = this.phone;
    data['nric'] = this.nric;
    data['is_probation'] = this.isProbation;
    data['is_married'] = this.isMarried;
    data['joined_date'] = this.joinedDate;
    data['tenure'] = this.tenure;
    data['position_level'] = this.positionLevel;
    data['created_at'] = this.createdAt;
    return data;
  }
}
