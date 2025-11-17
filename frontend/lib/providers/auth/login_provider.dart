import 'package:blindds_app/controllers/login_controller.dart';
import 'package:blindds_app/utils/base_provider.dart';
import 'package:blindds_app/utils/shared_preferences_utils.dart';

class LoginProvider extends BaseProvider {
  String email = '';
  String password = '';

  // Dados da sessão
  String id = '';
  String name = '';
  String userType = '';
  String access = '';
  String refresh = '';

  final LoginController controller;

  LoginProvider({required this.controller}) {
    // Carrega a sessão automaticamente quando o Provider é criado
    loadSession();
  }

  /// Realiza login e salva sessão
  Future<bool> loginUser() async {
    setLoading(true);
    clearError();

    try {
      final loginResult = await controller.login(email, password);

      if (loginResult == null) {
        setError("Falha ao fazer login.");
        return false;
      }

      // Atualiza os dados locais
      id = loginResult['id'] ?? '';
      name = loginResult['name'] ?? '';
      userType = loginResult['user_type'] ?? '';
      access = loginResult['access'] ?? '';
      refresh = loginResult['refresh'] ?? '';

      // Salvar no SharedPreferences
      await SessionStorage.saveData({
        'id': id,
        'name': name,
        'user_type': userType,
        'access': access,
        'refresh': refresh,
      });

      notifyListeners();
      return true;

    } catch (e) {
      setError(e.toString());
      return false;

    } finally {
      setLoading(false);
    }
  }

  /// Carrega a sessão do SharedPreferences
  Future<void> loadSession() async {
    setLoading(true);

    final data = await SessionStorage.loadData([
      'id',
      'name',
      'user_type',
      'access',
      'refresh',
    ]);

    id = data['id'] ?? '';
    name = data['name'] ?? '';
    userType = data['user_type'] ?? '';
    access = data['access'] ?? '';
    refresh = data['refresh'] ?? '';

    setLoading(false);
    notifyListeners();
  }

  /// Limpa tudo (Provider + SharedPreferences)
  Future<void> logout() async {
    id = '';
    name = '';
    userType = '';
    access = '';
    refresh = '';

    await SessionStorage.clearData([
      'id',
      'name',
      'user_type',
      'access',
      'refresh',
    ]);

    notifyListeners();
  }

  bool get isLoggedIn => access.isNotEmpty;
}
