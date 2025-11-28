import 'package:blindds_app/config/app_config.dart';
import 'package:blindds_app/utils/exceptions/app_exceptions.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:dio/dio.dart';
import 'dart:developer' as developer;

class AuthGoogleRemoteDatasource {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.baseURL));

  Future<Response> loginWithGoogle({required String idToken}) async {
    try {
      final response = await _dio.post(
        'auth/social/',
        data: {'firebase_id_token': idToken},
      );

      developer.log(
        'Resposta recebida do backend: ${response.statusCode}',
        name: 'LoginGoogleService',
      );

      return response;
    } on DioException catch (e, stackTrace) {
      final message = DioErrorHelper.handle(e);

      developer.log(
        'Erro DioException: $message',
        name: 'LoginGoogleService',
        error: e,
        stackTrace: stackTrace,
      );

      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(message);
      } else {
        throw ServerException(message);
      }
    } catch (e, stackTrace) {
      final message = GenericErrorHelper.handle(e);

      developer.log(
        'Erro inesperado: $message',
        name: 'LoginGoogleService',
        error: e,
        stackTrace: stackTrace,
      );

      throw AppException(message);
    }
  }
}
