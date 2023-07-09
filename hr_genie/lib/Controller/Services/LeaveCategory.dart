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
        return "12 days left";
      case LEAVES.medical:
        return "10 days left";
      case LEAVES.parental:
        return "7 days left";
      case LEAVES.emergency:
        return "6 days left";
      case LEAVES.unpaid:
        return "22 days left";
      default:
    }
  }
}
