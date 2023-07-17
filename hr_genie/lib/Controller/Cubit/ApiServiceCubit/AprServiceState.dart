import 'package:equatable/equatable.dart';
import 'package:hr_genie/Model/LeaveModel.dart';
import 'package:hr_genie/Model/LeaveQuotaModel.dart';

enum ApiServiceStatus { initial, loading, success, failed }

class ApiServiceState extends Equatable {
  // final String? endpoint;
  List<LeaveQuota?>? leaveQuotaList;
  List<Leave?>? allRequestList;
  List<Leave?>? pendingList;
  List<Leave?>? approvedList;
  List<Leave?>? rejectedList;
  List<Leave?>? myLeaveList;
  ApiServiceStatus status;
  String? errorMsg;
  String? putRequestMsg;
  bool? successApply;

  ApiServiceState(
      {required this.allRequestList,
      required this.leaveQuotaList,
      required this.status,
      required this.pendingList,
      required this.approvedList,
      required this.rejectedList,
      required this.myLeaveList,
      this.errorMsg,
      this.putRequestMsg,
      this.successApply = false});

  factory ApiServiceState.initial() {
    return ApiServiceState(
        status: ApiServiceStatus.initial,
        allRequestList: null,
        leaveQuotaList: null,
        pendingList: null,
        myLeaveList: null,
        approvedList: null,
        rejectedList: null,
        errorMsg: null,
        putRequestMsg: null);
  }

  ApiServiceState copyWith(
      {ApiServiceStatus? status,
      List<LeaveQuota?>? leaveQuotaList,
      List<Leave?>? allRequestList,
      List<Leave?>? pendingList,
      List<Leave?>? approvedList,
      List<Leave?>? rejectedList,
      List<Leave?>? myLeaveList,
      String? errorMsg,
      String? putRequestMsg,
      bool? successApply}) {
    return ApiServiceState(
        status: status ?? this.status,
        allRequestList: allRequestList ?? this.allRequestList,
        leaveQuotaList: leaveQuotaList ?? this.leaveQuotaList,
        pendingList: pendingList ?? this.pendingList,
        myLeaveList: myLeaveList ?? this.myLeaveList,
        approvedList: approvedList ?? this.approvedList,
        rejectedList: rejectedList ?? this.rejectedList,
        errorMsg: errorMsg ?? this.errorMsg,
        putRequestMsg: putRequestMsg ?? this.putRequestMsg,
        successApply: successApply ?? this.successApply);
  }

  @override
  List<Object?> get props => [
        status,
        leaveQuotaList,
        allRequestList,
        pendingList,
        approvedList,
        rejectedList,
        myLeaveList,
        errorMsg,
        putRequestMsg,
        successApply
      ];
}
