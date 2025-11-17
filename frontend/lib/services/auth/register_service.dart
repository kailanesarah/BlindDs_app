import 'package:blindds_app/services/api_client.dart';
import 'package:blindds_app/utils/exceptions/app_exceptions.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:dio/dio.dart';

class RegisterService {
  final ApiClient apiClient = ApiClient();
  late final Dio _dio;

  RegisterService() {
    _dio = apiClient.dio;
  }

  Future<Response> registerUser({
    required String name,
    required String email,
    required String password,
    required String userType,
  }) async {
    try {
      final response = await _dio.post(
        'auth/registration/',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'user_type': userType,
        },
      );

      return response;
    } on DioException catch (e) {
      final message = DioErrorHelper.handle(e);

      if (e.type == DioExceptionType.connectionError) {
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
