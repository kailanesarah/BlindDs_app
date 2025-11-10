import 'package:blindds_app/utils/exceptions/app_exceptions.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:dio/dio.dart';
import 'package:blindds_app/services/api_client.dart';

class LoginGoogleService {
  final ApiClient apiClient = ApiClient();
  late final Dio _dio;

  LoginGoogleService() {
    _dio = apiClient.dio;
  }

  Future<Response> loginWithGoogle({required String idToken}) async {
    try {
      final response = await _dio.post(
        'auth/social/',
        data: {'firebase_id_token': idToken},
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
