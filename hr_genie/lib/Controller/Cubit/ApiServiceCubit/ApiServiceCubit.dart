import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hr_genie/Controller/Cubit/ApiServiceCubit/AprServiceState.dart';
import 'package:hr_genie/Controller/Services/CallApi.dart';
import 'package:hr_genie/Model/DepartmentModel.dart';
import 'package:hr_genie/Model/EmployeeModel.dart';
import 'package:hr_genie/Model/HolidayModel.dart';
import 'package:hr_genie/Model/LeaveQuotaModel.dart';
import 'package:http/http.dart' as http;

class ApiServiceCubit extends Cubit<ApiServiceState> {
  ApiServiceCubit() : super(ApiServiceState.initial());
  // final String localhost = "172.20.10.12";
  final String localhost = "192.168.18.46";

  Future<List<Department>> fetchDepartments() async {
    final response =
        await http.get(Uri.parse('http://$localhost:2000/departments'));

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
    final url = Uri.parse('http://$localhost:2000/departments/create');
    final jsonData = department.toJson();
    http.Response response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(jsonData),
    );
    if (response.statusCode == 200) {
    } else {}
  }

  Future<List<Employee>> fetchEmployees() async {
    final response =
        await http.get(Uri.parse('http://$localhost:2000/employees'));

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

  Future<void> addEmployee(Employee employee) async {
    final url = Uri.parse('http://$localhost:2000/register');
    final jsonData = employee.toJson();
    http.Response response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(jsonData),
    );
    if (response.statusCode == 200) {
    } else {}
  }

  Future<void> fetchLeaveQuota(String accessToken) async {
    http.Response response = await CallApi().fetchLeaveQuota(accessToken);
    print("Running fetchLeaveQuota");
    final jsonData = json.decode(response.body);
    final List<dynamic> data = jsonData['data'];
    List<LeaveQuota> leaveQuotaList = [];
    for (var item in data) {
      LeaveQuota leaveQuota = LeaveQuota.fromJson(item);
      leaveQuotaList.add(leaveQuota);
    }
    emit(state.copyWith(leaveQuotaList: leaveQuotaList));
  }
}
