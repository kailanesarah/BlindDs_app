import 'dart:convert';
import 'package:blindds_app/services/auth/login_firebase_service.dart';
import 'package:blindds_app/services/auth/login_google_service.dart';
import 'package:blindds_app/controllers/token_controller.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';

class LoginGoogleController {
  final LoginFirebaseService firebaseService;
  final LoginGoogleService googleService;
  final TokenController tokenController;

  LoginGoogleController({
    required this.firebaseService,
    required this.googleService,
    required this.tokenController,
  });

  /// Faz login com Google e salva dados no Drift via TokenController
  Future<void> loginWithGoogle() async {
    try {
      // 1. Login no Firebase
      final UserCredential? credential = await firebaseService.signInWithGoogle();
      print("Firebase credential: $credential");

      if (credential == null || credential.user == null) {
        throw Exception("Login cancelado pelo usuário.");
      }

      final user = credential.user;
      final idToken = await user?.getIdToken();
      print("Firebase ID token: $idToken");

      if (idToken == null) {
        await FirebaseAuth.instance.signOut();
        throw Exception("Não foi possível obter o token do Firebase.");
      }

      // 2. Envia o token para o backend Django e recebe resposta
      final response = await googleService.loginWithGoogle(idToken: idToken);
      print("Resposta do backend (raw): ${response.data}");

      if (response.statusCode != 200) {
        throw Exception("Erro no servidor: ${response.data}");
      }

      // 3. Ajuste para o formato {detail: ..., data: {user: ..., tokens: ...}}
      final rawData = response.data;
      final data = rawData is Map ? rawData : jsonDecode(rawData.toString());

      if (!data.containsKey('data')) {
        throw Exception("O retorno do servidor não contém 'data'");
      }

      final backendData = Map<String, dynamic>.from(data['data']);

      if (!backendData.containsKey('user') || !backendData.containsKey('tokens')) {
        throw Exception("O retorno do servidor não contém 'user' ou 'tokens'");
      }

      final userData = Map<String, dynamic>.from(backendData['user']);
      final tokens = Map<String, dynamic>.from(backendData['tokens']);

      final id = userData["id"]?.toString();
      final name = userData["username"]; // backend envia 'username'
      final email = userData["email"];
      final userType = userData["user_type"];
      final access = tokens["access"];
      final refresh = tokens["refresh"];

      if (id == null || access == null || refresh == null) {
        throw Exception("Login retornou dados inválidos");
      }

      // 4. Salva dados no Drift via TokenController
      await tokenController.local.saveUser(
        id: id,
        name: name ?? '',
        email: email ?? '',
        userType: userType ?? '',
        access: access,
        refresh: refresh,
      );

      print("Login Google realizado com sucesso: $name, $email");
    } on DioException catch (e) {
      throw Exception(DioErrorHelper.handle(e));
    } catch (e) {
      throw Exception(GenericErrorHelper.handle(e));
    }
  }

  /// Retorna dados do usuário armazenados no Drift
  Future<Map<String, String>> getUserData() async {
    final data = await tokenController.local.getUser();

    if (data.isEmpty) {
      return {
        'id': '',
        'name': '',
        'email': '',
        'userType': '',
        'access': '',
        'refresh': '',
      };
    }

    return {
      'id': data['id'] ?? '',
      'name': data['name'] ?? '',
      'email': data['email'] ?? '',
      'userType': data['userType'] ?? '',
      'access': data['access'] ?? '',
      'refresh': data['refresh'] ?? '',
    };
  }

  /// Limpa dados do usuário no Drift
  Future<void> logout() async {
    await tokenController.local.clear();
    await FirebaseAuth.instance.signOut();
  }
}
