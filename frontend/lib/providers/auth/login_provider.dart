import 'dart:convert';
import 'package:blindds_app/utils/base_provider.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:blindds_app/utils/validators.dart';
import 'package:blindds_app/providers/session/load_session_provider.dart';
import 'package:blindds_app/providers/session/register_session_provider.dart';
import 'package:blindds_app/services/login_service.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginProvider extends BaseProvider {
  String email = '';
  String password = '';

  String? emailError;
  String? passwordError;

  final LoginService _loginService;
  final RegisterSessionProvider _registerSessionProvider;

  LoginProvider({
    required LoginService loginService,
    required RegisterSessionProvider registerSessionProvider,
  }) : _loginService = loginService,
       _registerSessionProvider = registerSessionProvider;

  Future<bool> login(BuildContext context) async {
    emailError = Validators.validateEmail(email);
    passwordError = Validators.validatePassword(password);
    clearError();

    if (emailError != null || passwordError != null) {
      notifyListeners();
      return false;
    }

    setLoading(true);

    try {
      final Response response = await _loginService.loginUser(
        email: email,
        password: password,
      );

      if (response.statusCode == 200) {
        final data = response.data is Map
            ? response.data
            : jsonDecode(response.data);

        // Salva e atualiza sessão
        await _registerSessionProvider.saveSession(data);

        final loadSession = Provider.of<LoadSessionProvider>(
          context,
          listen: false,
        );
        loadSession.updateSession(data);

        setLoading(false);
        return true;
      } else {
        final body = response.data is Map
            ? response.data
            : jsonDecode(response.data);
        setError(body['detail'] ?? 'Falha ao fazer login.');
        setLoading(false);
        return false;
      }
    } on DioException catch (e) {
      setError(DioErrorHelper.handle(e));
      setLoading(false);
      return false;
    } catch (e) {
      setError(GenericErrorHelper.handle(e));
      setLoading(false);
      return false;
    }
  }
}
