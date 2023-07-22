class ErrorModel {
  ErrorModel({
    required this.errorMsg,
  });
  late final String errorMsg;

  ErrorModel.fromJson(Map<String, dynamic> json) {
    errorMsg = json['error'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['error'] = errorMsg;
    return data;
  }
}
