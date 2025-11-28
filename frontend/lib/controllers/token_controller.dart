import 'package:blindds_app/database/app_database.dart';
import 'package:blindds_app/database/datasources/user_local_datasource.dart';
import 'package:blindds_app/services/api_client.dart';
import 'package:blindds_app/services/auth/refresh_service.dart';
import 'package:dio/dio.dart';
import 'package:blindds_app/config/app_config.dart';

class TokenController {
  final AppDatabase db;

  late final UserLocalDataSource local;
  late final Dio dio;
  late final RefreshService refreshService;
  late final ApiClient apiClient;

  TokenController({required this.db}) {
    local = UserLocalDataSource(db);

    dio = Dio(BaseOptions(baseUrl: AppConfig.baseURL));

    refreshService = RefreshService(
      dio: dio,
      local: local,
    );
    
    apiClient = ApiClient(
      dio: dio,
      local: local,
      refreshService: refreshService,
    );
  }

  Future<String?> refreshAccessManually() => refreshService.refreshToken();
}