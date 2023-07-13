import 'package:equatable/equatable.dart';
import 'package:hr_genie/Model/LeaveModel.dart';
import 'package:hr_genie/Model/LeaveQuotaModel.dart';

enum ApiServiceStatus { initial, loading, success, failed }

class ApiServiceState extends Equatable {
  // final String? endpoint;
  List<LeaveQuota?>? leaveQuotaList;
  List<Leave?>? leaveApprovalList;

  ApiServiceState(
      {required this.leaveQuotaList, required this.leaveApprovalList});

  factory ApiServiceState.initial() {
    return ApiServiceState(leaveQuotaList: null, leaveApprovalList: null);
  }

  ApiServiceState copyWith(
      {List<LeaveQuota?>? leaveQuotaList, List<Leave?>? leaveApprovalList}) {
    return ApiServiceState(
        leaveQuotaList: leaveQuotaList ?? this.leaveQuotaList,
        leaveApprovalList: leaveApprovalList ?? this.leaveApprovalList);
  }

  @override
  List<Object?> get props => [leaveQuotaList];
}
