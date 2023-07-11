import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:hr_genie/Model/DepartmentModel.dart';
import 'package:hr_genie/Model/LeaveQuotaModel.dart';

enum ApiServiceStatus { initial, loading, success, failed }

class ApiServiceState extends Equatable {
  // final String? endpoint;
  List<LeaveQuota?>? leaveQuotaList;

  ApiServiceState({
    required this.leaveQuotaList,
    // required this.endpoint,
  });

  factory ApiServiceState.initial() {
    return ApiServiceState(leaveQuotaList: null);
  }

  ApiServiceState copyWith({List<LeaveQuota?>? leaveQuotaList}) {
    return ApiServiceState(
        leaveQuotaList: leaveQuotaList ?? this.leaveQuotaList);
  }

  @override
  List<Object?> get props => [leaveQuotaList];
}
