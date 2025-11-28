import 'package:blindds_app/controllers/login_controller.dart';
import 'package:blindds_app/utils/base_provider.dart';

class LoginProvider extends BaseProvider {
  String email = '';
  String password = '';

  String id = '';
  String name = '';
  String userType = '';
  String access = '';
  String refresh = '';

  final LoginController controller;

  LoginProvider({required this.controller});

  /// Inicializa sessão async
  Future<void> init() async {
    await loadSession();
  }

  /// Carrega dados do Drift
  Future<void> loadSession() async {
    setLoading(true);
    clearError();

    try {
      final userData = await controller.getUserData();
      id = userData['id'] ?? '';
      name = userData['name'] ?? '';
      userType = userData['userType'] ?? '';
      access = userData['access'] ?? '';
      refresh = userData['refresh'] ?? '';

      print("USER LOADED: $name");
    } catch (e) {
      id = '';
      name = '';
      userType = '';
      access = '';
      refresh = '';
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  Future<bool> loginUser() async {
    setLoading(true);
    clearError();

    try {
      await controller.login(email, password);
      await loadSession();
      return true;
    } catch (e) {
      setError(e.toString().replaceAll("Exception: ", ""));
      return false;
    } finally {
      setLoading(false);
    }
  }

  Future<void> logout() async {
    setLoading(true);
    clearError();

    try {
      await controller.clearUserData();

      id = '';
      name = '';
      userType = '';
      access = '';
      refresh = '';
      notifyListeners();
    } catch (e) {
      setError(e.toString().replaceAll("Exception: ", ""));
    } finally {
      setLoading(false);
    }
  }

  bool get isLoggedIn => access.isNotEmpty;
}
