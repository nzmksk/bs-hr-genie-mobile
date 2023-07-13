class ErrorModel {
  ErrorModel({
    required this.errorMsg,
  });
  late final String errorMsg;

  ErrorModel.fromJson(Map<String, dynamic> json) {
    errorMsg = json['error'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = errorMsg;
    return _data;
  }
}
