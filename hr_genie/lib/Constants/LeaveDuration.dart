enum LeaveDuration { fullDay, firstHalf, secondHalf }

extension LeaveString on LeaveDuration {
  String? get value {
    switch (this) {
      case LeaveDuration.fullDay:
        return "full-day";
      case LeaveDuration.firstHalf:
        return "first-half";
      case LeaveDuration.secondHalf:
        return "second-half";
      default:
        return null;
    }
  }
}
