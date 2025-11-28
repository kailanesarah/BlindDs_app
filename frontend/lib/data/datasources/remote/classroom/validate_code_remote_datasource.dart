import 'package:blindds_app/data/datasources/remote/api_client_remote_datasource.dart';
import 'package:blindds_app/utils/exceptions/app_exceptions.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:dio/dio.dart';

class ValidateCodeDataSource {
  final ApiClient _apiClient;

  ValidateCodeDataSource({required ApiClient api}) : _apiClient = api;

  Dio get _dio => _apiClient.dio;

  Future<Response> validateCode({required String code}) async {
    try {
      final response = await _dio.post(
        'classroom/validate-code/',
        data: {"code": code},
      );
      return response;
    } on DioException catch (e) {
      final message = DioErrorHelper.handle(e);

      if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(message);
      }

      throw ServerException(message);
    } catch (e) {
      final message = GenericErrorHelper.handle(e);

      throw AppException(message);
    }
  }
}
