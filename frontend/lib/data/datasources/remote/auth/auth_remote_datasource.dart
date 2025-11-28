import 'package:blindds_app/config/app_config.dart';
import 'package:blindds_app/utils/exceptions/app_exceptions.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio _dio = Dio(BaseOptions(baseUrl: AppConfig.baseURL));

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
        throw AuthException(message);
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(message);
      } else {
        throw ServerException(message);
      }
    } catch (e) {
      final message = GenericErrorHelper.handle(e);
      throw AppException(message);
    }
  }
}
