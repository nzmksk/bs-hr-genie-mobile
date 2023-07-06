// enum Role { employee, manager, admin, resigned }

// enum Gender { male, female }

class Employee {
  String? departmentId;
  String? employeeId;
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
  int? age;

  Employee({
    this.employeeId,
    required this.departmentId,
    required this.employeeRole,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.email,
    this.hashPassword,
    this.phone,
    required this.nric,
    this.isProbation,
    this.isMarried,
    this.joinedDate,
    this.tenure,
    this.age,
  });

  Employee.fromJson(Map<String, dynamic> json) {
    departmentId = json['department_id'];
    employeeId = json['employee_id'];
    employeeRole = json['employee_role'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    email = json['email'];
    phone = json['phone'];
    nric = json['nric'];
    isProbation = json['is_probation'];
    isMarried = json['is_married'];
    joinedDate = json['joined_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['department_id'] = this.departmentId;
    data['employee_role'] = this.employeeRole;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['nric'] = this.nric;
    data['is_probation'] = this.isProbation;
    data['is_married'] = this.isMarried;
    data['joined_date'] = this.joinedDate;

    return data;
  }
}
