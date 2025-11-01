import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:blindds_app/providers/session/load_session_provider.dart';
import 'package:blindds_app/providers/session/register_session_provider.dart';
import 'package:blindds_app/services/login_service.dart';
import 'package:blindds_app/utils/validators.dart';
import 'package:provider/provider.dart';

class LoginProvider with ChangeNotifier {
  String email = '';
  String password = '';

  String? emailError;
  String? passwordError;
  String? errorMessage;
  bool isLoading = false;

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
    errorMessage = null;

    if (emailError != null || passwordError != null) {
      notifyListeners();
      return false;
    }

    isLoading = true;
    notifyListeners();

    try {
      final response = await _loginService.loginUser(
        email: email,
        password: password,
      );

      isLoading = false;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await _registerSessionProvider.saveSession(data);

        // Atualiza LoadSessionProvider
        final loadSession = Provider.of<LoadSessionProvider>(
          context,
          listen: false,
        );
        loadSession.updateSession(data);
        notifyListeners();

        return true;
      } else {
        final body = jsonDecode(response.body);
        errorMessage = body['detail'] ?? 'Login falhou';
        notifyListeners();
        return false;
      }
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
