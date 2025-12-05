import 'package:blindds_app/domain/services/auth/auth_service.dart';
import 'package:blindds_app/domain/entities/user_entity.dart';
import 'package:blindds_app/utils/base_provider.dart';

class AuthProvider extends BaseProvider {
  final AuthService _authService;
  UserEntity? _currentUser;

  String emailInput = '';
  String passwordInput = '';

  AuthProvider({required AuthService authService}) : _authService = authService;

  // Getters públicos para acesso da UI
  UserEntity? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser?.accessToken.isNotEmpty ?? false;

  /// Carrega dados do Drift
  Future<void> init() async {
    setLoading(true);
    clearError();

    try {
      _currentUser = await _authService.getCurrentUser();

      if (_currentUser != null) {
        print("USER LOADED: ${_currentUser!.username}");
      }
    } catch (e) {
      _currentUser = null;
      print("Erro ao carregar sessão: $e");
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  Future<bool> loginUser() async {
    setLoading(true);
    clearError();

    try {
      final user = await _authService.signIn(emailInput, passwordInput);

      _currentUser = user;
      return true;
    } catch (e) {
      setError(e.toString().replaceAll("Exception: ", ""));
      return false;
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  Future<bool> loginWithGoogle() async {
    setLoading(true);
    clearError();

    try {
      final user = await _authService.signInWithGoogle();

      _currentUser = user;
      return true;
    } catch (e) {
      setError(e.toString().replaceAll("Exception: ", ""));
      return false;
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  Future<bool> logout() async {
    setLoading(true);
    clearError();

    try {
      await _authService.signOut();

      _currentUser = null;

      return true;
    } catch (e) {
      setError(e.toString().replaceAll("Exception: ", ""));
      return false;
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }
}
