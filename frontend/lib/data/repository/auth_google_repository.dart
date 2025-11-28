import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:blindds_app/data/datasources/local/user/user_local_datasource.dart';
import 'package:blindds_app/domain/entities/user_entity.dart';

import 'package:blindds_app/data/datasources/remote/auth/auth_google_remote_datasource.dart';
import 'package:blindds_app/data/datasources/remote/auth/auth_firebase_remote_datasource.dart';

import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';

class AuthGoogleRepository {
  final AuthGoogleRemoteDatasource _googleRemoteDataSource;
  final UserLocalDataSource _localDataSource;
  final AuthFirebaseDataSource _authFirebaseDataSource;

  AuthGoogleRepository({
    required AuthFirebaseDataSource authFirebaseDataSource,
    required AuthGoogleRemoteDatasource googleRemoteDataSource,
    required UserLocalDataSource localDataSource,
  }) : _authFirebaseDataSource = authFirebaseDataSource,
       _googleRemoteDataSource = googleRemoteDataSource,
       _localDataSource = localDataSource;

  Future<UserEntity> loginWithGoogle() async {
    try {
      final String idToken = await _authFirebaseDataSource.getIdToken();

      final response = await _googleRemoteDataSource.loginWithGoogle(
        idToken: idToken,
      );

      if (response.statusCode != 200) {
        throw Exception("Erro no servidor: ${response.data}");
      }

      // ------------------------------------------------------------
      // Parse seguro do retorno (lida com Map ou String JSON)
      // ------------------------------------------------------------

      final rawData = response.data;
      final data = rawData is Map ? rawData : jsonDecode(rawData.toString());

      if (!data.containsKey('data')) {
        throw Exception("O retorno do servidor não contém 'data'");
      }

      final backendData = Map<String, dynamic>.from(data['data']);

      if (!backendData.containsKey('user') ||
          !backendData.containsKey('tokens')) {
        throw Exception("O servidor retornou dados incompletos");
      }

      final userData = Map<String, dynamic>.from(backendData['user']);
      final tokens = Map<String, dynamic>.from(backendData['tokens']);

      // ------------------------------------------------------------
      //  JSON unificado para o UserEntity
      // ------------------------------------------------------------

      final unifiedUserData = {
        ...userData,
        'access': tokens['access'],
        'refresh': tokens['refresh'],
      };

      final userEntity = UserEntity.fromJson(unifiedUserData);

      await _localDataSource.saveUser(userEntity);

      return userEntity;
    } on DioException catch (e) {
      throw Exception(DioErrorHelper.handle(e));
    } catch (e) {
      throw Exception(GenericErrorHelper.handle(e));
    }
  }

  Future<UserEntity?> getUserData() async {
    return _localDataSource.getUser();
  }

  Future<void> logout() async {
    await _localDataSource.clear();
    await FirebaseAuth.instance.signOut();
  }
}
