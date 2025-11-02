import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadSessionProvider with ChangeNotifier {
  String? id;
  String? email;
  String? username;
  String? name;
  String? userType;
  bool? hasMfa;
  String? accessToken;
  String? refreshToken;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  // Carrega os dados da sessão do SharedPreferences
  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();

    id = prefs.getString('id');
    email = prefs.getString('email');
    username = prefs.getString('username');
    name = prefs.getString('name');
    userType = prefs.getString('userType');
    hasMfa = prefs.getBool('hasMfa');
    accessToken = prefs.getString('access');
    refreshToken = prefs.getString('refresh');

    _isLoaded = true;
    notifyListeners();
  }

  // Atualiza os dados da sessão **apenas em memória**
  void updateSession(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    username = data['username'];
    email = data['email'];
    userType = data['user_type'];
    hasMfa = data['has_mfa'];
    accessToken = data['access'];
    refreshToken = data['refresh'];

    _isLoaded = true;
    notifyListeners();
  }
}
