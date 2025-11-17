import 'package:blindds_app/services/api_client.dart';
import 'package:blindds_app/utils/exceptions/app_exceptions.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:dio/dio.dart';

class ValidateCodeService {
  final ApiClient apiClient = ApiClient();
  late final Dio _dio;

  ValidateCodeService() {
    _dio = apiClient.dio;
  }

  Future<Response> validateCode({required String atvCode}) async {
    try {
      final response = await _dio.post(
        'homework/validate_code/',
        data: {"atv_code": atvCode},
      );

      return response;
    } on DioException catch (e) {
      final message = DioErrorHelper.handle(e);

      if (e.type == DioExceptionType.connectionError) {
        // erro de rede
        throw NetworkException(message);
      } else {
        // erro de API (400, 404, 500 etc)
        throw ServerException(message);
      }
    } catch (e) {
      // erro inesperado, não relacionado ao Dio
      final message = GenericErrorHelper.handle(e);
      throw AppException(message);
    }
  }
}
