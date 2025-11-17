import 'dart:convert';
import 'package:blindds_app/services/auth/login_service.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:dio/dio.dart';

class LoginController {
  final LoginService loginService;

  LoginController({required this.loginService});

  Future<Map<String, dynamic>?> login(String email, String password) async {
    try {
      final response = await loginService.loginUser(
        email: email,
        password: password,
      );

      if (response.statusCode == 200) {
        // Garante que o retorno seja Map
        final data = response.data is Map
            ? response.data
            : jsonDecode(response.data);

        return data;
      } else {
        return null; // login falhou
      }
    } on DioException catch (e) {
      throw Exception(DioErrorHelper.handle(e));
    } catch (e) {
      throw Exception(GenericErrorHelper.handle(e));
    }
  }
}
