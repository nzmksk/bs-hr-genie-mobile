enum LeaveDuration { fullDay, firstHalf, secondHalf }

extension LeaveString on LeaveDuration {
  String? get value {
    switch (this) {
      case LeaveDuration.fullDay:
        return "Full-Day";
      case LeaveDuration.firstHalf:
        return "First-Half (9:00 AM - 1:00 PM)";
      case LeaveDuration.secondHalf:
        return "Second-Half (2:00 PM - 6:00)";
      default:
        return null;
    }
  }
}
