import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:hr_genie/Model/DepartmentModel.dart';

enum ApiServiceStatus { initial, loading, success, failed }

class ApiServiceState extends Equatable {
  final String endpoint;
  var model;

  ApiServiceState({required this.model, required this.endpoint});

  factory ApiServiceState.initial() {
    return ApiServiceState(endpoint: "", model: null);
  }
  @override
  List<Object?> get props => [endpoint, model];
}
