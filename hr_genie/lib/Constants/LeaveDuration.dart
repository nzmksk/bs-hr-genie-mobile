enum LeaveDuration { fullDay, firstHalf, secondHalf }

extension LeaveString on LeaveDuration {
  String? get value {
    switch (this) {
      case LeaveDuration.fullDay:
        return "Full Day";
      case LeaveDuration.firstHalf:
        return "First Half";
      case LeaveDuration.secondHalf:
        return "Second Half";
      default:
        return null;
    }
  }
}
