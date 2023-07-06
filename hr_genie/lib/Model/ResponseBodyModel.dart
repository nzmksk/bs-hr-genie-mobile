// ignore_for_file: file_names

class ResponseBody {
  String? message;
  String? token;
  String? error;

  ResponseBody({this.message, this.token, this.error});

  ResponseBody.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'message': message,
      'token': token,
      'error': error,
    };
    return data;
  }
}
