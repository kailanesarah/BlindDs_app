import 'package:blindds_app/config/app_config.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blindds_app/services/auth/refresh_service.dart';
import 'dart:developer';

class ApiClient {
  final Dio dio = Dio(BaseOptions(baseUrl: AppConfig.baseURL));
  late final RefreshService refreshService = RefreshService(dio);

  ApiClient() {
    try {
      dio.interceptors.add(
        InterceptorsWrapper(
          //Intercepta a requisição antes de ser enviada
          onRequest: (options, handler) async {
            try {
              final prefs = await SharedPreferences.getInstance();
              final token = prefs.getString('access');

              if (token != null) {
                options.headers['Authorization'] = 'Bearer $token';
              }
            } catch (e, stack) {
              log(
                'Erro ao recuperar token do SharedPreferences: $e',
                stackTrace: stack,
              );
            }

            return handler.next(options);
          },

          // Intercepta erros (como 401 Unauthorized)
          onError: (DioException e, handler) async {
            try {
              if (e.response?.statusCode == 401) {
                log('Token expirado. Tentando atualizar...');

                final newToken = await refreshService.refreshToken();

                if (newToken != null) {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString('access', newToken);

                  e.requestOptions.headers['Authorization'] =
                      'Bearer $newToken';

                  // Reenvia a requisição original com o novo token
                  final cloneReq = await dio.fetch(e.requestOptions);

                  return handler.resolve(cloneReq);
                } else {
                  log('Falha ao renovar o token: refresh retornou null');
                }
              }
            } catch (err, stack) {
              log(
                'Erro ao tentar renovar token ou refazer requisição: $err',
                stackTrace: stack,
              );
            }

            return handler.next(e);
          },
        ),
      );
    } catch (e, stack) {
      log('Erro ao configurar interceptors do Dio: $e', stackTrace: stack);
    }
  }
}
