import 'package:blindds_app/controllers/login_google_controller.dart';
import 'package:blindds_app/utils/base_provider.dart';

class LoginGoogleProvider extends BaseProvider {
  // Dados da sessão
  String id = '';
  String name = '';
  String email = '';
  String userType = '';
  String access = '';
  String refresh = '';

  final LoginGoogleController controller;

  LoginGoogleProvider({required this.controller});

  /// Inicializa o provider carregando dados do Drift
  Future<void> init() async {
    print("Inicializando LoginGoogleProvider...");
    await loadSession();
    print("Sessão carregada: id=$id, name=$name");
  }

  /// Realiza login com Google
  Future<bool> loginUserWithGoogle() async {
    setLoading(true);
    clearError();

    try {
      await controller.loginWithGoogle();

      // Depois do login, pega os dados salvos no Drift
      final userData = await controller.getUserData();

      id = userData['id'] ?? '';
      name = userData['name'] ?? '';
      email = userData['email'] ?? '';
      userType = userData['userType'] ?? '';
      access = userData['access'] ?? '';
      refresh = userData['refresh'] ?? '';

      print("Dados do usuário após login: id=$id, name=$name, email=$email");

      notifyListeners();
      return true;
    } catch (e) {
      setError(e.toString().replaceAll("Exception: ", ""));
      print("Erro no loginUserWithGoogle: $e");
      return false;
    } finally {
      setLoading(false);
    }
  }

  /// Carrega sessão diretamente do Drift via controller
  Future<void> loadSession() async {
    setLoading(true);

    final userData = await controller.getUserData();

    id = userData['id'] ?? '';
    name = userData['name'] ?? '';
    email = userData['email'] ?? '';
    userType = userData['userType'] ?? '';
    access = userData['access'] ?? '';
    refresh = userData['refresh'] ?? '';

    setLoading(false);
    notifyListeners();
  }

  /// Limpa a sessão via controller
  Future<void> logout() async {
    id = '';
    name = '';
    email = '';
    userType = '';
    access = '';
    refresh = '';

    await controller.logout();

    notifyListeners();
  }

  bool get isLoggedIn => access.isNotEmpty;
}
