import 'package:blindds_app/domain/entities/user_entity.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:blindds_app/data/datasources/remote/auth/auth_remote_datasource.dart';
import 'package:blindds_app/data/datasources/local/user/user_local_datasource.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final UserLocalDataSource _localDataSource;

  AuthRepository({
    required AuthRemoteDataSource remoteDataSource,
    required UserLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  Future<UserEntity> login(String email, String password) async {
    try {
      final rawData = await _remoteDataSource.loginUser(
        email: email,
        password: password,
      );

      final userEntity = UserEntity.fromJson(rawData.data);

      await _localDataSource.saveUser(userEntity);

      return userEntity;
    } on DioException catch (e) {
      throw Exception(DioErrorHelper.handle(e));
    } on Exception catch (e) {
      throw Exception(GenericErrorHelper.handle(e));
    }
  }

  Future<UserEntity?> getUser() async {
    final user = await _localDataSource.getUser();
    return user;
  }

  Future<void> updateTokens({required String access, String? refresh}) async {
    await _localDataSource.updateTokens(access: access, refresh: refresh);
  }

  Future<void> clearUserData() async {
    await _localDataSource.clear();
  }
}
