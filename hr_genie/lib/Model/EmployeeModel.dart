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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['departmentId'] = departmentId;
    data['employeeRole'] = employeeRole;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['gender'] = gender;
    data['email'] = email;
    data['position'] = position;
    data['phone'] = phone;
    data['nric'] = nric;
    data['isMarried'] = isMarried;
    data['joinedDate'] = joinedDate;
    data['profileImage'] = profileImage;
    data['lastLogin'] = lastLogin;
    data['isPasswordUpdated'] = isPasswordUpdated;

    return data;
  }
}
