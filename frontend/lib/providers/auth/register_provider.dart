import 'package:blindds_app/controllers/register_controller.dart';
import 'package:blindds_app/utils/base_provider.dart';
import 'package:blindds_app/utils/validators.dart';

class RegisterProvider extends BaseProvider {
  String name = '';
  String email = '';
  String password = '';
  String userType = 'aluno';

  String? nameError;
  String? emailError;
  String? passwordError;

  final RegisterController controller;

  RegisterProvider({required this.controller});

  /// Muda o tipo de usuário
  void setUserType(String type) {
    userType = type;
    notifyListeners();
  }

  /// Valida campos antes do envio
  bool validateFields() {
    nameError = Validators.validateUsername(name);
    emailError = Validators.validateEmail(email);
    passwordError = Validators.validatePassword(password);

    if (nameError != null || emailError != null || passwordError != null) {
      notifyListeners();
      return false;
    }

    return true;
  }

  /// Usa o controller para registrar
  Future<bool> register() async {
    if (!validateFields()) return false;

    clearError();
    setLoading(true);

    final String? error = await controller.register(
      name: name,
      email: email,
      password: password,
      userType: userType,
    );

    setLoading(false);

    if (error != null) {
      setError(error);
      return false;
    }

    return true;
  }
}
