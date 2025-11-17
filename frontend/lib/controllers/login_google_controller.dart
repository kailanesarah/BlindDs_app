import 'dart:convert';
import 'package:blindds_app/services/auth/login_firebase_service.dart';
import 'package:blindds_app/services/auth/login_google_service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';

class LoginGoogleController {
  final LoginFirebaseService firebaseService;
  final LoginGoogleService googleService;

  LoginGoogleController({
    required this.firebaseService,
    required this.googleService,
  });

  Future<Map<String, dynamic>?> loginWithGoogle() async {
    try {
      // 1. Login no Firebase
      final UserCredential? credential =
          await firebaseService.signInWithGoogle();

      if (credential == null || credential.user == null) {
        throw Exception("Login cancelado pelo usuário.");
      }

      final user = credential.user;
      final idToken = await user?.getIdToken();

      if (idToken == null) {
        await FirebaseAuth.instance.signOut();
        throw Exception("Não foi possível obter o token do Firebase.");
      }

      // 2. Envia o token para o backend Django
      final Response response =
          await googleService.loginWithGoogle(idToken: idToken);

      if (response.statusCode != 200) {
        throw Exception("Erro no servidor: ${response.data}");
      }

      // 3. Garante que o dado esteja em Map
      final data = response.data is Map
          ? response.data
          : jsonDecode(response.data);

      final userData = Map<String, dynamic>.from(data['user']);
      final tokens = Map<String, dynamic>.from(data['tokens']);

      // 4. Mapeia exatamente como seu Provider espera
      return {
        "id": userData["id"],
        "name": userData["name"],
        "email": userData["email"],
        "user_type": userData["user_type"],
        "access": tokens["access"],
        "refresh": tokens["refresh"],
      };
    } on DioException catch (e) {
      throw Exception(DioErrorHelper.handle(e));
    } catch (e) {
      throw Exception(GenericErrorHelper.handle(e));
    }
  }
}
