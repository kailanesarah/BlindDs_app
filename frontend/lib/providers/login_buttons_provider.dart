import 'package:flutter/material.dart';

class LoginButtonsProvider extends ChangeNotifier {
  bool loginLoading = false;
  bool googleLoading = false;

  bool get disableAll => loginLoading || googleLoading;

  void startLogin() {
    loginLoading = true;
    googleLoading = true; // desabilita o google
    notifyListeners();
  }

  void endLogin() {
    loginLoading = false;
    googleLoading = false;
    notifyListeners();
  }

  void startGoogle() {
    googleLoading = true;
    loginLoading = true; // desabilita o login normal
    notifyListeners();
  }

  void endGoogle() {
    googleLoading = false;
    loginLoading = false;
    notifyListeners();
  }
}
