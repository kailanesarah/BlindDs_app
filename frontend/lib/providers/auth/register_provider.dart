import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:blindds_app/services/register_service.dart';
import 'package:blindds_app/utils/validators.dart';

class RegisterProvider with ChangeNotifier {
  String name = '';
  String email = '';
  String password = '';
  String userType = 'aluno';

  String? nameError;
  String? emailError;
  String? passwordError;
  String? errorMessage;
  bool isLoading = false;

  final RegisterService _registerService;

  RegisterProvider({required RegisterService registerService})
    : _registerService = registerService;

  void setUserType(String type) {
    userType = type;
    notifyListeners();
  }

  Future<bool> validateFields() async {
    nameError = Validators.validateUsername(name);
    emailError = Validators.validateEmail(email);
    passwordError = Validators.validatePassword(password);

    if (nameError != null || emailError != null || passwordError != null) {
      notifyListeners();
      return false;
    }
    return true;
  }

  Future<bool> register() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _registerService.registerUser(
        name: name,
        email: email,
        password: password,
        userType: userType,
      );

      isLoading = false;

      if (response.statusCode == 200 || response.statusCode == 201) {
        notifyListeners();
        return true;
      } else {
        final body = jsonDecode(response.body);
        errorMessage = body['detail'] ?? 'Registro falhou';
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
