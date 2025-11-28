import 'package:blindds_app/data/datasources/local/user/user_local_datasource.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class RefreshService {
  final Dio dio;
  final UserLocalDataSource local;
  final Logger _logger = Logger();

  RefreshService({required this.dio, required this.local});

  Future<String?> refreshToken() async {
    final refresh = await local.getRefreshToken();

    if (refresh == null) {
      return null;
    }

    try {
      _logger.i('Renovando token...');

      final response = await dio.post(
        'auth/refresh/',
        data: {'refresh': refresh},
      );

      if (response.statusCode == 200 && response.data['access'] != null) {
        final newAccess = response.data['access'];

        // Atualiza APENAS o access (refresh permanece o mesmo)
        await local.updateTokens(access: newAccess);

        _logger.i('Token renovado com sucesso!');
        return newAccess;
      }
    } catch (e, s) {
      _logger.e('Erro ao renovar token', error: e, stackTrace: s);
      return null;
    }

    return null;
  }
}
