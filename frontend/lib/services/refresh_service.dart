import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class RefreshService {
  final Dio _dio;
  final logger = Logger();
  RefreshService(this._dio);

  Future<String?> refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refresh = prefs.getString('refresh');
    if (refresh == null) return null;

    try {
      final response = await _dio.post(
        '/auth/refresh/',
        data: {'refresh': refresh},
      );
      if (response.statusCode == 200) {
        final newAccess = response.data['access'];
        await prefs.setString('access', newAccess); // salva o novo token
        return newAccess;
      }
    } catch (e, stackTrace) {
      logger.e('Erro ao renovar token', error: e, stackTrace: stackTrace);
    }
    return null;
  }
}
