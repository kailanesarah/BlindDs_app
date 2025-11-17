import 'package:blindds_app/controllers/login_google_controller.dart';
import 'package:blindds_app/utils/base_provider.dart';
import 'package:blindds_app/utils/shared_preferences_utils.dart';

class LoginGoogleProvider extends BaseProvider {
  // Dados da sessão
  String id = '';
  String name = '';
  String email = '';
  String userType = '';
  String access = '';
  String refresh = '';

  final LoginGoogleController controller;

  LoginGoogleProvider({required this.controller}) {
    // Carrega sessão automaticamente quando o provider é criado
    loadSession();
  }

  /// Realiza login com Google e salva sessão
  Future<bool> loginUserWithGoogle() async {
    setLoading(true);
    clearError();

    try {
      final sessionData = await controller.loginWithGoogle();

      if (sessionData == null) {
        setError("Falha ao autenticar com Google.");
        return false;
      }

      // Atualiza os dados locais
      id = sessionData['id'] ?? '';
      name = sessionData['name'] ?? '';
      email = sessionData['email'] ?? '';
      userType = sessionData['user_type'] ?? '';
      access = sessionData['access'] ?? '';
      refresh = sessionData['refresh'] ?? '';

      // Salvar no SharedPreferences
      await SessionStorage.saveData({
        'id': id,
        'name': name,
        'email': email,
        'user_type': userType,
        'access': access,
        'refresh': refresh,
      });

      notifyListeners();
      return true;

    } catch (e) {
      setError(e.toString().replaceAll("Exception: ", ""));
      return false;

    } finally {
      setLoading(false);
    }
  }

  /// Carrega sessão diretamente do SharedPreferences
  Future<void> loadSession() async {
    setLoading(true);

    final data = await SessionStorage.loadData([
      'id',
      'name',
      'email',
      'user_type',
      'access',
      'refresh',
    ]);

    id = data['id'] ?? '';
    name = data['name'] ?? '';
    email = data['email'] ?? '';
    userType = data['user_type'] ?? '';
    access = data['access'] ?? '';
    refresh = data['refresh'] ?? '';

    setLoading(false);
    notifyListeners();
  }

  /// Limpa toda a sessão
  Future<void> logout() async {
    id = '';
    name = '';
    email = '';
    userType = '';
    access = '';
    refresh = '';

    await SessionStorage.clearData([
      'id',
      'name',
      'email',
      'user_type',
      'access',
      'refresh',
    ]);

    notifyListeners();
  }

  bool get isLoggedIn => access.isNotEmpty;
}
