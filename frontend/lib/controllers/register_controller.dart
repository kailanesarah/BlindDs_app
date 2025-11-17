import 'package:blindds_app/services/auth/register_service.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:dio/dio.dart';

class RegisterController {
  final RegisterService service;

  RegisterController({required this.service});

  Future<String?> register({
    required String name,
    required String email,
    required String password,
    required String userType,
  }) async {
    try {
      final response = await service.registerUser(
        name: name,
        email: email,
        password: password,
        userType: userType,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return null; // sucesso → sem erro
      }

      return response.data['detail'] ?? "Erro ao registrar.";
    } on DioException catch (e) {
      return DioErrorHelper.handle(e);
    } catch (e) {
      return GenericErrorHelper.handle(e);
    }
  }
}
