import 'package:hr_genie/Model/LeaveCategoryModel.dart';

enum LEAVES { annual, medical, parental, emergency, unpaid }

extension LeaveCatergoriesList on LEAVES {
  LeaveCategory get leaveTypeName {
    switch (this) {
      case LEAVES.annual:
        return LeaveCategory(leaveTitle: "Annual Leave");
      case LEAVES.medical:
        return LeaveCategory(leaveTitle: "Medical Leave");
      case LEAVES.parental:
        return LeaveCategory(leaveTitle: "Parental Leave");
      case LEAVES.emergency:
        return LeaveCategory(leaveTitle: "Emergency Leave");
      case LEAVES.unpaid:
        return LeaveCategory(leaveTitle: "Unpaid Leave");
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
}
