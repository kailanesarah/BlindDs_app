import 'package:blindds_app/utils/exceptions/app_exceptions.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:dio/dio.dart';
import 'package:blindds_app/services/api_client.dart';

class LoginService {
  final ApiClient apiClient = ApiClient();
  late final Dio _dio;

  LoginService() {
    _dio = apiClient.dio;
  }

  Future<Response> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        'auth/login/',
        data: {'email': email, 'password': password},
      );
      return response;
    } on DioException catch (e) {
      final message = DioErrorHelper.handle(e);

      if (e.response?.statusCode == 400) {
        // Erros de autenticação
        throw AuthException(message);
      } else if (e.type == DioExceptionType.connectionError) {
        // Erros de rede
        throw NetworkException(message);
      } else {
        // Erros gerais do servidor
        throw ServerException(message);
      }
    } catch (e) {
      // Erros não relacionados ao Dio
      final message = GenericErrorHelper.handle(e);
      throw AppException(message);
    }
  }
}
