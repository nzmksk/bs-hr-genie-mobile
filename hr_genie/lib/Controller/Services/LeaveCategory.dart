import 'package:hr_genie/Model/LeaveCategoryModel.dart';

enum LEAVES { annual, medical, parental, emergency, unpaid }

extension LeaveCatergoriesList on LEAVES {
  LeaveCategory get leaveTypeName {
    switch (this) {
      case LEAVES.annual:
        return LeaveCategory(leaveTitle: "Annual");
      case LEAVES.medical:
        return LeaveCategory(leaveTitle: "Medical");
      case LEAVES.parental:
        return LeaveCategory(leaveTitle: "Parental");
      case LEAVES.emergency:
        return LeaveCategory(leaveTitle: "Emergency");
      case LEAVES.unpaid:
        return LeaveCategory(leaveTitle: "Unpaid");
      default:
    }
    return LeaveCategory(leaveTitle: "unrecognized");
  }

  LeaveCategory get id {
    switch (this) {
      case LEAVES.annual:
        return LeaveCategory(leaveTypeId: "ANL");
      case LEAVES.medical:
        return LeaveCategory(leaveTypeId: "MCL");
      case LEAVES.parental:
        return LeaveCategory(leaveTypeId: "PRL");
      case LEAVES.emergency:
        return LeaveCategory(leaveTypeId: "EML");
      case LEAVES.unpaid:
        return LeaveCategory(leaveTypeId: "UNL");
      default:
    }
    return LeaveCategory(leaveTitle: "ERR");
  }

  String? get quota {
    switch (this) {
      case LEAVES.annual:
        return "(Remaining: 12 days)";
      case LEAVES.medical:
        return "(Remaining: 10 days)";
      case LEAVES.parental:
        return "(Remaining: 7 days)";
      case LEAVES.emergency:
        return "(Remaining: 6 days)";
      case LEAVES.unpaid:
        return "(Remaining: 22 days)";
      default:
    }
  }
}
