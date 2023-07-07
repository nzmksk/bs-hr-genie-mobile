// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;

class CallApi {
  String baseUrl = 'http://192.168.18.46:2000';

  Future<http.Response> postLogin({
    required email,
    required password,
  }) async {
    http.Response response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );
    return response;
  }
}
