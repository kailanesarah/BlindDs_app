import 'package:blindds_app/domain/services/classroom/validate_code_service.dart';
import 'package:blindds_app/utils/base_provider.dart';

class ValidateCodeProvider extends BaseProvider {
  final ValidateCodeService _service;

  String codeInput = '';

  ValidateCodeProvider({required ValidateCodeService service})
      : _service = service;

  void setCodeInput(String value) {
    codeInput = value;
  }

  Future<bool> validateCode() async {
    setLoading(true);
    clearError();
    notifyListeners();

    try {
      await _service.validateCode(codeInput.trim());
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
