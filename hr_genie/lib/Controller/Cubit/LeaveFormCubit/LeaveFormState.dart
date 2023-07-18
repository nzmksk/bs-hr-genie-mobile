import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hr_genie/Constants/ApplicationStatus.dart';

enum LeaveStatus { initial, loading, sent, error }

//Change the enum to a String
extension ParseToString on Duration {
  String toShortString() {
    return toString().split('.').last;
  }
}

class LeaveFormState extends Equatable {
  final String? leaveType;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<DateTime>? dateRange;
  final String? duration;
  final String? reason;
  final Uint8List? attachment;
  final AppStatus appStatus;
  final String? approvedBy;
  final String? rejectReason;
  final bool isValidReason;
  final bool isValidLeaveType;
  final bool firstStepDone;
  final bool secStepDone;
  final bool thirdStepDone;
  final bool dateStored;
  final LeaveStatus? status;
  final bool rejectReasonNotEmpty;
  final bool successApply;

  const LeaveFormState(
      {this.firstStepDone = false,
      this.secStepDone = false,
      this.thirdStepDone = false,
      this.leaveType,
      this.reason,
      this.attachment,
      this.approvedBy,
      this.rejectReason,
      this.appStatus = AppStatus.pending,
      this.duration,
      this.startDate,
      this.endDate,
      this.dateRange,
      this.isValidReason = false,
      this.isValidLeaveType = false,
      this.dateStored = false,
      this.status,
      this.rejectReasonNotEmpty = false,
      this.successApply = false});

  factory LeaveFormState.initial() {
    return const LeaveFormState(reason: null);
  }

  LeaveFormState copyWith({
    ValueGetter<String?>? leaveType,
    ValueGetter<DateTime?>? startDate,
    ValueGetter<DateTime?>? endDate,
    ValueGetter<List<DateTime>?>? dateRange,
    String? duration,
    ValueGetter<String?>? reason,
    Uint8List? attachment,
    AppStatus? appStatus,
    String? approvedBy,
    String? rejectReason,
    bool? isValidReason,
    bool? isValidLeaveType,
    bool? firstStepDone,
    bool? secStepDone,
    bool? thirdStepDone,
    bool? dateStored,
    LeaveStatus? status,
    bool? rejectReasonNotEmpty,
    bool? successApply,
  }) {
    return LeaveFormState(
        leaveType: leaveType != null ? leaveType() : this.leaveType,
        startDate: startDate != null ? startDate() : this.startDate,
        endDate: endDate != null ? endDate() : this.endDate,
        dateRange: dateRange != null ? dateRange() : this.dateRange,
        duration: duration ?? this.duration,
        reason: reason != null ? reason() : this.reason,
        attachment: attachment ?? this.attachment,
        appStatus: appStatus ?? this.appStatus,
        approvedBy: approvedBy ?? this.approvedBy,
        rejectReason: rejectReason ?? this.rejectReason,
        isValidReason: isValidReason ?? this.isValidReason,
        isValidLeaveType: isValidLeaveType ?? this.isValidLeaveType,
        firstStepDone: firstStepDone ?? this.firstStepDone,
        secStepDone: secStepDone ?? this.secStepDone,
        thirdStepDone: thirdStepDone ?? this.thirdStepDone,
        dateStored: dateStored ?? this.dateStored,
        status: status ?? this.status,
        rejectReasonNotEmpty: rejectReasonNotEmpty ?? this.rejectReasonNotEmpty,
        successApply: successApply ?? this.successApply);
  }

  @override
  List<Object?> get props => [
        leaveType,
        startDate,
        endDate,
        dateRange,
        duration,
        reason,
        attachment,
        appStatus,
        approvedBy,
        rejectReason,
        isValidReason,
        isValidLeaveType,
        firstStepDone,
        secStepDone,
        thirdStepDone,
        dateStored,
        status,
        rejectReasonNotEmpty,
        successApply
      ];
}
