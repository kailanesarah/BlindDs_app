import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  static const String _baseURL = "http://10.0.2.2:8000/api/v1/";

  Future<http.Response> loginUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('${_baseURL}auth/login/');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    return response;
  }
}
