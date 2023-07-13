enum AppStatus { pending, approved, rejected, cancelled }

extension AppStatusList on AppStatus {
  String get string {
    switch (this) {
      case AppStatus.pending:
        return "Pending";
      case AppStatus.approved:
        return "Approved";
      case AppStatus.rejected:
        return "Rejected";
      case AppStatus.cancelled:
        return "Cancelled";
      default:
    }
    return "Unrecognized";
  }
}
