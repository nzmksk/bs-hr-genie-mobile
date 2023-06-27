import 'dart:typed_data';

import 'package:equatable/equatable.dart';

enum LeaveStatus { initial }

enum Duration { fullDay, firstHalf, secondHalf }

enum AppStatus { pending, approved, rejected }

//Change the enum to a String
extension ParseToString on Duration {
  String toShortString() {
    return toString().split('.').last;
  }
}

class LeaveFormState extends Equatable {
  final DateTime? startDate;
  final Duration? duration;
  final String? reason;
  final Uint8List? attachment;
  final AppStatus appStatus;
  final String? approvedBy;
  final String? rejectReason;

  const LeaveFormState({
    this.reason,
    this.attachment,
    this.approvedBy,
    this.rejectReason,
    this.appStatus = AppStatus.pending,
    required this.duration,
    required this.startDate,
  });

  factory LeaveFormState.initial() {
    return const LeaveFormState(duration: null, startDate: null);
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
