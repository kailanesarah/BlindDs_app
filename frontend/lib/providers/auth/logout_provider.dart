import 'package:blindds_app/utils/base_provider.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutProvider extends BaseProvider {
  User? _firebaseUser;
  Map<String, dynamic>? _djangoTokens;
  bool _isAuthenticated = false;

  // Getters
  User? get firebaseUser => _firebaseUser;
  Map<String, dynamic>? get djangoTokens => _djangoTokens;
  bool get isAuthenticated => _isAuthenticated;

  Future<bool> logout() async {
    setLoading(true);
    clearError();

    try {
      await FirebaseAuth.instance.signOut();

      // Remove tokens JWT locais
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('access');
      await prefs.remove('refresh');

      // Limpa estado local
      _firebaseUser = null;
      _djangoTokens = null;
      _isAuthenticated = false;

      setLoading(false);
      return true;
    } catch (e) {
      setError(GenericErrorHelper.handle(e));
      setLoading(false);
      return false;
    }
  }
}
