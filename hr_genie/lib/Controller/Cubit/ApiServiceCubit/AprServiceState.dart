import 'package:equatable/equatable.dart';
import 'package:hr_genie/Model/LeaveModel.dart';
import 'package:hr_genie/Model/LeaveQuotaModel.dart';

enum ApiServiceStatus { initial, loading, success, failed }

class ApiServiceState extends Equatable {
  // final String? endpoint;
  List<LeaveQuota?>? leaveQuotaList;
  List<Leave?>? pendingList;
  List<Leave?>? approvedList;
  List<Leave?>? rejectedList;

  List<Leave?>? myLeaveList;

  ApiServiceState(
      {required this.leaveQuotaList,
      required this.pendingList,
      required this.approvedList,
      required this.rejectedList,
      required this.myLeaveList});

  factory ApiServiceState.initial() {
    return ApiServiceState(
        leaveQuotaList: null,
        pendingList: null,
        myLeaveList: null,
        approvedList: null,
        rejectedList: null);
  }

  ApiServiceState copyWith(
      {List<LeaveQuota?>? leaveQuotaList,
      List<Leave?>? pendingList,
      List<Leave?>? approvedList,
      List<Leave?>? rejectedList,
      List<Leave?>? myLeaveList}) {
    return ApiServiceState(
        leaveQuotaList: leaveQuotaList ?? this.leaveQuotaList,
        pendingList: pendingList ?? this.pendingList,
        myLeaveList: myLeaveList ?? this.myLeaveList,
        approvedList: approvedList ?? this.approvedList,
        rejectedList: rejectedList ?? this.rejectedList);
  }

  @override
  List<Object?> get props =>
      [leaveQuotaList, pendingList, approvedList, rejectedList, myLeaveList];
}
