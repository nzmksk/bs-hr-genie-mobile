class RefreshToken {
  RefreshToken({
    required this.message,
    required this.token,
  });
  late final String message;
  late final String token;

  RefreshToken.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['token'] = token;
    return data;
  }
}
