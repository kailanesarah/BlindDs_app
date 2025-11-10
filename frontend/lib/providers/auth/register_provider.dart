import 'package:blindds_app/utils/base_provider.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:blindds_app/utils/validators.dart';
import 'package:blindds_app/services/register_service.dart';
import 'package:dio/dio.dart';

class RegisterProvider extends BaseProvider {
  String name = '';
  String email = '';
  String password = '';
  String userType = 'aluno';

  String? nameError;
  String? emailError;
  String? passwordError;

  final RegisterService _registerService;

  RegisterProvider({required RegisterService registerService})
    : _registerService = registerService;

  /// Define o tipo de usuário (ex: aluno, professor, empresa, etc)
  void setUserType(String type) {
    userType = type;
    notifyListeners();
  }

  /// Valida todos os campos antes do envio
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

  /// Envia os dados de registro para o backend
  Future<bool> register() async {
    if (!validateFields()) return false;

    setLoading(true);
    clearError();

    try {
      final Response response = await _registerService.registerUser(
        name: name,
        email: email,
        password: password,
        userType: userType,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        setLoading(false);
        return true;
      } else {
        final data = response.data;
        setError(data['detail'] ?? 'Falha ao registrar o usuário.');
        setLoading(false);
        return false;
      }
    } on DioException catch (e) {
      setError(DioErrorHelper.handle(e));
      setLoading(false);
      return false;
    } catch (e) {
      setError(GenericErrorHelper.handle(e));
      setLoading(false);
      return false;
    }
  }
}
