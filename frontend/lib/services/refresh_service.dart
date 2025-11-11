import 'package:blindds_app/utils/exceptions/app_exceptions.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class RefreshService {
  final Dio _dio;
  final Logger _logger = Logger();

  RefreshService(this._dio);

  Future<String?> refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refresh = prefs.getString('refresh');

    if (refresh == null) {
      _logger.w('Nenhum refresh token encontrado no armazenamento.');
      return null;
    }

    try {
      final response = await _dio.post(
        '/auth/refresh/',
        data: {'refresh': refresh},
      );

      if (response.statusCode == 200 && response.data['access'] != null) {
        final newAccess = response.data['access'];

        await prefs.setString('access', newAccess);
        _logger.i('Token de acesso renovado com sucesso.');

        return newAccess;
      } else {
        _logger.w(
          'Falha ao renovar token. Código: ${response.statusCode}, Dados: ${response.data}',
        );
      }
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

    return null;
  }
}
