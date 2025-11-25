import 'package:blindds_app/database/datasources/user_local_datasource.dart';
import 'package:blindds_app/services/auth/refresh_service.dart';
import 'package:dio/dio.dart';
import 'dart:developer' as developer;

class ApiClient {
  final Dio dio;
  final UserLocalDataSource local;
  final RefreshService refreshService;

  ApiClient({
    required this.dio,
    required this.local,
    required this.refreshService,
  }) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Sempre pega o token atualizado
          final token = await local.getAccessToken();

          developer.log(
            '🔐 Enviando requisição com token: $token',
            name: 'ApiClient',
          );

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          handler.next(options);
        },

        onError: (error, handler) async {
          // Se error 401 → tenta refresh
          if (error.response?.statusCode == 401) {
            developer.log(
              '⚠ Token expirou. Tentando renovar...',
              name: 'ApiClient',
            );

            final newToken = await refreshService.refreshToken();

            if (newToken != null) {
              developer.log(
                '🔄 Novo token obtido! Repetindo requisição...',
                name: 'ApiClient',
              );

              // Coloca novo token
              error.requestOptions.headers['Authorization'] =
                  'Bearer $newToken';

              // Repete requisição com novo token
              final retryResponse = await dio.fetch(error.requestOptions);
              return handler.resolve(retryResponse);
            }

            developer.log(
              '❌ Falha ao renovar token.',
              name: 'ApiClient',
            );
          }

          handler.next(error);
        },
      ),
    );
  }
}
