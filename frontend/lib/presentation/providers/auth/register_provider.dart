import 'package:blindds_app/domain/services/auth/register_service.dart';
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

  final RegisterService _service;

  RegisterProvider({required RegisterService service}) : _service = service;

  /// Atualiza o tipo do usuário
  void setUserType(String type) {
    userType = type;
    notifyListeners();
  }

  /// Validação dos campos
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

  /// Chama service → repository → datasource
  Future<bool> register() async {
    if (!validateFields()) return false;

    clearError();
    setLoading(true);

    await _service.register(
      name: name,
      email: email,
      password: password,
      userType: userType,
    );

    setLoading(false);

    return true;
  }
}
