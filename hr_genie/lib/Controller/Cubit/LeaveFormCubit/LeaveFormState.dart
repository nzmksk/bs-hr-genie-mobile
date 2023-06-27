import 'dart:typed_data';

import 'package:equatable/equatable.dart';
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
  final TYPE? leaveType;
  final DateTime? startDate;
  final LeaveDuration? duration;
  final String? reason;
  final Uint8List? attachment;
  final AppStatus appStatus;
  final String? approvedBy;
  final String? rejectReason;

  const LeaveFormState({
    this.leaveType,
    this.reason,
    this.attachment,
    this.approvedBy,
    this.rejectReason,
    this.appStatus = AppStatus.pending,
    this.duration,
    this.startDate,
  });

  factory LeaveFormState.initial() {
    return const LeaveFormState();
  }

  LeaveFormState copyWith({
    TYPE? leaveType,
    DateTime? startDate,
    LeaveDuration? duration,
    String? reason,
    Uint8List? attachment,
    AppStatus? appStatus,
    String? approvedBy,
    String? rejectReason,
  }) {
    return LeaveFormState(
        leaveType: leaveType ?? this.leaveType,
        startDate: startDate ?? this.startDate,
        duration: duration ?? this.duration,
        reason: reason ?? this.reason,
        attachment: attachment ?? this.attachment,
        appStatus: appStatus ?? this.appStatus,
        approvedBy: approvedBy ?? this.approvedBy,
        rejectReason: rejectReason ?? this.rejectReason);
  }

  @override
  List<Object?> get props => [
        startDate,
        duration,
        reason,
        attachment,
        appStatus,
        approvedBy,
        rejectReason
      ];
}
