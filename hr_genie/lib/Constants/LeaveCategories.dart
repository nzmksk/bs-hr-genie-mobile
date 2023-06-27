enum TYPE { annual, medical, parental, emergency, unpaid }

extension CategoriesString on TYPE {
  String? get values {
    switch (this) {
      case TYPE.annual:
        return "Annual";
      case TYPE.medical:
        return "Medical";
      case TYPE.parental:
        return "Parental";
      case TYPE.emergency:
        return "Emergency";
      case TYPE.unpaid:
        return "Unpaid";
      default:
        return null;
    }
  }
}
