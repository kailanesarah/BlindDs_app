import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blindds_app/services/refresh_service.dart';

class ApiClient {
  final Dio dio = Dio(BaseOptions(baseUrl: 'http://10.0.2.2:8000/api/v1/'));
  late final RefreshService refreshService;

  ApiClient() {
    refreshService = RefreshService(dio); // injeta o RefreshService

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('access');

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },

        onError: (e, handler) async {
          if (e.response?.statusCode == 401) {
            final newToken = await refreshService.refreshToken();

            if (newToken != null) {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('access', newToken);

              e.requestOptions.headers['Authorization'] = 'Bearer $newToken';

              final cloneReq = await dio.fetch(e.requestOptions);
              return handler.resolve(cloneReq);
            }
          }
          return handler.next(e);
        },
      ),
    );
  }
}
