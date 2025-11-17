import 'package:blindds_app/controllers/validate_code_controller.dart';
import 'package:blindds_app/utils/base_provider.dart';
import 'package:blindds_app/utils/shared_preferences_utils.dart';

class ValidateCodeProvider extends BaseProvider {
  String code = '';
  String? atvName;
  String? atvDescription;
  String? atvDeadline;
  bool isLoaded = false;

  final ValidateCodeController _controller;

  ValidateCodeProvider({required ValidateCodeController controller})
      : _controller = controller;

  Future<bool> validateCode() async {
    setLoading(true);
    clearError();

    try {
      final data = await _controller.validateCode(code);

      // Preenche os dados vindos do backend
      atvName = data["atv_name"] ?? "";
      atvDescription = data["atv_description"] ?? "";
      atvDeadline = data["atv_deadline"] ?? "";
      code = data["atv_code"] ?? code;

      // Salva no SharedPreferences
      await SessionStorage.saveData({
        "atv_name": atvName,
        "atv_description": atvDescription,
        "atv_deadline": atvDeadline,
        "atv_code": code,
      });

      isLoaded = true;
      notifyListeners();
      return true;

    } catch (e) {
      setError(e.toString().replaceAll("Exception: ", ""));
      return false;
    } finally {
      setLoading(false);
    }
  }

  /// Carrega os dados da atividade do SharedPreferences
  Future<void> loadActivityData() async {
    if (isLoaded) return;

    final data = await SessionStorage.loadData([
      "atv_name",
      "atv_description",
      "atv_deadline",
      "atv_code",
    ]);

    atvName = data["atv_name"] ?? "Atividade";
    atvDescription = data["atv_description"] ?? "Sem descrição";
    atvDeadline = data["atv_deadline"] ?? "Sem prazo";
    code = data["atv_code"] ?? "000000";

    isLoaded = true;
    notifyListeners();
  }

  /// Limpa os dados da atividade (caso precise no futuro)
  Future<void> clearActivityData() async {
    atvName = null;
    atvDescription = null;
    atvDeadline = null;
    code = '';

    await SessionStorage.clearData([
      "atv_name",
      "atv_description",
      "atv_deadline",
      "atv_code",
    ]);

    isLoaded = false;
    notifyListeners();
  }
}
