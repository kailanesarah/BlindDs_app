import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterSessionProvider with ChangeNotifier {
  String id;
  String name;
  String email;
  String username;
  String userType;
  bool hasMfa;
  String access;
  String refresh;

  bool _isLoggedIn;

  RegisterSessionProvider({
    this.id = '',
    this.name = '',
    this.email = '',
    this.username = '',
    this.userType = '',
    this.hasMfa = false,
    this.access = '',
    this.refresh = '',
    bool isLoggedIn = false,
  }) : _isLoggedIn = isLoggedIn;

  bool get isLoggedIn => _isLoggedIn;

  void _setSessionFields(Map<String, dynamic> data) {
    id = data['id'] ?? '';
    name = data['name'] ?? '';
    email = data['email'] ?? '';
    username = data['username'] ?? '';
    userType = data['user_type'] ?? '';
    hasMfa = data['has_mfa'] ?? false;
    access = data['access'] ?? '';
    refresh = data['refresh'] ?? '';
    _isLoggedIn = access.isNotEmpty;
  }

  Future<void> saveSession(Map<String, dynamic> data) async {
    final session = await SharedPreferences.getInstance();

    await session.setString('id', data['id'] ?? '');
    await session.setString('name', data['name'] ?? '');
    await session.setString('email', data['email'] ?? '');
    await session.setString('username', data['username'] ?? '');
    await session.setString('userType', data['user_type'] ?? '');
    await session.setBool('hasMfa', data['has_mfa'] ?? false);
    await session.setString('access', data['access'] ?? '');
    await session.setString('refresh', data['refresh'] ?? '');

    _setSessionFields(data);
    notifyListeners();
  }
}
