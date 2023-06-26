import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hr_genie/Controller/cubit/AprServiceState.dart';
import 'package:hr_genie/Model/DepartmentModel.dart';
import 'package:hr_genie/Model/EmployeeModel.dart';
import 'package:http/http.dart' as http;

class ApiServiceCubit extends Cubit<ApiServiceState> {
  ApiServiceCubit() : super(ApiServiceState.initial());

  Future<List<Department>> fetchDepartments() async {
    final response =
        await http.get(Uri.parse('http://localhost:2000/departments'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> departmentData = jsonData['data'];
      final departments =
          departmentData.map((json) => Department.fromJson(json)).toList();
      return [...departments];
    } else {
      throw Exception('Failed to fetch departments');
    }
  }

  Future<void> addDepartment(Department department) async {
    final url = Uri.parse('http://0.0.0.0:2000/departments/create');
    final jsonData = department.toJson();
    http.Response response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(jsonData),
    );
    if (response.statusCode == 200) {
    } else {}
  }

  // http://localhost:2000/employees
  Future<List<Employee>> fetchEmployees() async {
    final response =
        await http.get(Uri.parse('http://localhost:2000/employees'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> departmentData = jsonData['data'];
      final employees =
          departmentData.map((json) => Employee.fromJson(json)).toList();
      return employees;
    } else {
      throw Exception('Failed to fetch departments');
    }
  }
  // Stream<List<Employee>> fetchEmployees() async* {
  //   final response =
  //       await http.get(Uri.parse('http://localhost:2000/employees'));

  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     final List<dynamic> employeeData = jsonData['data'];
  //     final employees =
  //         employeeData.map((json) => Employee.fromJson(json)).toList();
  //     yield employees;
  //   } else {
  //     throw Exception('Failed to fetch employees');
  //   }
  // }

  Future<void> addEmployee(Employee employee) async {
    final url = Uri.parse('http://0.0.0.0:2000/register');
    final jsonData = employee.toJson();
    http.Response response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(jsonData),
    );
    if (response.statusCode == 200) {
    } else {}
  }
}
