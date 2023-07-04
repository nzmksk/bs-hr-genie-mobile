import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hr_genie/Constants/ApplicationStatus.dart';
import 'package:hr_genie/Constants/LeaveDuration.dart';
import 'package:hr_genie/Constants/LeaveCategories.dart';

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
      this.dateRange,
      this.isValidReason = false,
      this.isValidLeaveType = false,
      this.dateStored = false,
      this.status});

  factory LeaveFormState.initial() {
    return const LeaveFormState(reason: null);
  }

  LeaveFormState copyWith({
    String? leaveType,
    ValueGetter<DateTime?>? startDate,
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
  }) {
    return LeaveFormState(
        leaveType: leaveType ?? this.leaveType,
        startDate: startDate != null ? startDate() : this.startDate,
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
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [
        leaveType,
        startDate,
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
        status
      ];
}
