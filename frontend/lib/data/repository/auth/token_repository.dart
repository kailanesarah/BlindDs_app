import 'package:blindds_app/data/datasources/local/app_database.dart';
import 'package:blindds_app/data/datasources/local/user/user_local_datasource.dart';
import 'package:blindds_app/data/datasources/remote/api_client_remote_datasource.dart';
import 'package:blindds_app/data/datasources/remote/auth/refresh__remote_datasource.dart';
import 'package:dio/dio.dart';
import 'package:blindds_app/config/app_config.dart';

class TokenRepository {
  final AppDatabase db;

  late final UserLocalDataSource local;
  late final Dio dio;
  late final RefreshService refreshService;
  late final ApiClient apiClient;

  TokenRepository({required this.db}) {
    local = UserLocalDataSource(db);

    dio = Dio(BaseOptions(baseUrl: AppConfig.baseURL));

    refreshService = RefreshService(dio: dio, local: local);

    apiClient = ApiClient(
      dio: dio,
      local: local,
      refreshService: refreshService,
    );
  }

  Future<String?> refreshAccessManually() => refreshService.refreshToken();
}
