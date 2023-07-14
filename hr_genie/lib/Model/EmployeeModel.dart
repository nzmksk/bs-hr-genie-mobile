// enum Role { employee, manager, admin, resigned }

// enum Gender { male, female }

import 'dart:ffi';

class Employee {
  String? departmentId;
  String? employeeId;
  String? employeeRole;
  String? firstName;
  String? lastName;
  String? gender;
  String? email;
  String? position;
  String? phone;
  String? nric;
  bool? isMarried;
  String? joinedDate;
  Uint8? profileImage;
  String? createdAt;
  String? lastLogin;
  bool? isPasswordUpdated;

  Employee({
    this.employeeId,
    required this.departmentId,
    required this.employeeRole,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.email,
    required this.position,
    required this.nric,
    this.phone,
    this.isMarried,
    this.joinedDate,
    this.profileImage,
    this.createdAt,
    this.lastLogin,
    this.isPasswordUpdated,
  });

  Employee.fromJson(Map<String, dynamic> json) {
    departmentId = json['departmentId'];
    employeeId = json['employeeId'];
    employeeRole = json['employeeRole'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    email = json['email'];
    position = json['position'];
    nric = json['nric'];
    phone = json['phone'];
    isMarried = json['isMarried'];
    joinedDate = json['joinedDate'];
    profileImage = json['profileImage'];
    createdAt = json['createdAt'];
    lastLogin = json['lastLogin'];
    isPasswordUpdated = json['isPasswordUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['departmentId'] = this.departmentId;
    data['employeeRole'] = this.employeeRole;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['position'] = this.position;
    data['phone'] = this.phone;
    data['nric'] = this.nric;
    data['isMarried'] = this.isMarried;
    data['joinedDate'] = this.joinedDate;
    data['profileImage'] = this.profileImage;
    data['lastLogin'] = this.lastLogin;
    data['isPasswordUpdated'] = this.isPasswordUpdated;

    return data;
  }
}
