import 'package:blindds_app/data/datasources/remote/api_client_remote_datasource.dart';
import 'package:blindds_app/utils/exceptions/app_exceptions.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:dio/dio.dart';

class ClassroomRemoteDataSource {
  final ApiClient _apiClient;

  ClassroomRemoteDataSource({required ApiClient api}) : _apiClient = api;

  Dio get _dio => _apiClient.dio;

  Future<Response> getClassroom(String classroomId) async {
    try {
      final response = await _dio.get('classroom/$classroomId/');
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
