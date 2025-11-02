import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterService {
  static const String _baseURL = "http://10.0.2.2:8000/api/v1/";

  Future<http.Response> registerUser({
    required String name,
    required String email,
    required String password,
    required String userType,
  }) async {
    final url = Uri.parse('${_baseURL}auth/registration/');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'user_type': userType,
      }),
    );

    return response;
  }
}
