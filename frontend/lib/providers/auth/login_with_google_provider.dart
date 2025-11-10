import 'dart:convert';
import 'package:blindds_app/utils/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:blindds_app/providers/session/load_session_provider.dart';
import 'package:blindds_app/providers/session/register_session_provider.dart';
import 'package:blindds_app/services/login_google_service.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:blindds_app/services/login_firebase_service.dart';

class LoginGoogleProvider extends BaseProvider {
  final LoginGoogleService _loginGoogleService;
  final RegisterSessionProvider _registerSessionProvider;

  User? _firebaseUser;
  bool _isAuthenticated = false;

  User? get firebaseUser => _firebaseUser;
  bool get isAuthenticated => _isAuthenticated;

  LoginGoogleProvider({
    required LoginGoogleService loginGoogleService,
    required RegisterSessionProvider registerSessionProvider,
  }) : _loginGoogleService = loginGoogleService,
       _registerSessionProvider = registerSessionProvider;

  Future<bool> loginWithGoogleAndDjango(BuildContext context) async {
    setLoading(true);
    _isAuthenticated = false;
    clearError();

    try {
      final UserCredential? userCredential = await signInWithGoogle();
      if (userCredential == null || userCredential.user == null) {
        setError('Login cancelado pelo usuário.');
        return false;
      }

      _firebaseUser = userCredential.user;
      final String? firebaseIdToken = await _firebaseUser?.getIdToken();

      if (firebaseIdToken == null) {
        await FirebaseAuth.instance.signOut();
        _firebaseUser = null;
        setError('Não foi possível obter o token do Firebase.');
        return false;
      }

      final response = await _loginGoogleService.loginWithGoogle(
        idToken: firebaseIdToken,
      );

      if (response.statusCode == 200) {
        final data = response.data is Map
            ? response.data
            : jsonDecode(response.data);
        final userData = Map<String, dynamic>.from(data['user']);
        final tokensData = Map<String, dynamic>.from(data['tokens']);

        final sessionData = {
          ...userData,
          'access': tokensData['access'],
          'refresh': tokensData['refresh'],
        };

        await _registerSessionProvider.saveSession(sessionData);

        _isAuthenticated = true;

        final loadSession = Provider.of<LoadSessionProvider>(
          context,
          listen: false,
        );
        loadSession.updateSession(sessionData);
        //loadSession.debugSession();

        notifyListeners();
        return true;
      } else {
        await FirebaseAuth.instance.signOut();
        _firebaseUser = null;

        String serverError = 'Erro desconhecido no servidor.';
        if (response.data is Map && response.data['detail'] != null) {
          serverError = response.data['detail'];
        }

        setError('Erro no login com o servidor. ($serverError)');
        return false;
      }
    } on DioException catch (e) {
      setError(DioErrorHelper.handle(e));
      await FirebaseAuth.instance.signOut();
      _firebaseUser = null;
      return false;
    } catch (e) {
      setError(GenericErrorHelper.handle(e));
      await FirebaseAuth.instance.signOut();
      _firebaseUser = null;
      return false;
    } finally {
      setLoading(false);
    }
  }
}
