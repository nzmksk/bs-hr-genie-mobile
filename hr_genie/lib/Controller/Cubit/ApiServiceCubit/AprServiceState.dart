import 'package:equatable/equatable.dart';
import 'package:hr_genie/Model/LeaveModel.dart';
import 'package:hr_genie/Model/LeaveQuotaModel.dart';

enum ApiServiceStatus { initial, loading, success, failed }

class ApiServiceState extends Equatable {
  // final String? endpoint;
  List<LeaveQuota?>? leaveQuotaList;
  List<Leave?>? leaveRequestList;
  List<Leave?>? myLeaveList;

  ApiServiceState(
      {required this.leaveQuotaList,
      required this.leaveRequestList,
      required this.myLeaveList});

  factory ApiServiceState.initial() {
    return ApiServiceState(
        leaveQuotaList: null, leaveRequestList: null, myLeaveList: null);
  }

  ApiServiceState copyWith(
      {List<LeaveQuota?>? leaveQuotaList,
      List<Leave?>? leaveApprovalList,
      List<Leave?>? myLeaveList}) {
    return ApiServiceState(
        leaveQuotaList: leaveQuotaList ?? this.leaveQuotaList,
        leaveRequestList: leaveApprovalList ?? this.leaveRequestList,
        myLeaveList: myLeaveList ?? this.myLeaveList);
  }

  @override
  List<Object?> get props => [leaveQuotaList, leaveRequestList, myLeaveList];
}
