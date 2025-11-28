import 'package:blindds_app/controllers/validate_code_controller.dart';
import 'package:blindds_app/utils/base_provider.dart';
class ValidateCodeProvider extends BaseProvider {
  String? code;
  String? classroomName;
  String? classroomDescription;
  bool isLoaded = false;

  final ValidateCodeController controller;

  ValidateCodeProvider({required this.controller}) {
    loadClassroomSession();
  }

  Future<bool> validateCode() async {
    if (code == null || code!.isEmpty) {
      setError("O código não pode ficar vazio.");
      return false; 
    }

    setLoading(true);
    clearError();

    try {
      final data = await controller.validateCode(code!);

      // Atualiza estado do provider
      classroomName = data["name"] ?? "";
      classroomDescription = data["description"] ?? "";

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

  /// Carrega os dados da sala do controller (Drift)
  Future<void> loadClassroomSession() async {
    setLoading(true);
    clearError();

    try {
      final data = await controller.getClassroomData();

      if (data.isNotEmpty) {
        code = data["code"];
        classroomName = data["name"] ?? "Sala";
        classroomDescription = data["description"] ?? "Sem descrição";
        isLoaded = true;
      }
    } catch (e) {
      setError(e.toString().replaceAll("Exception: ", ""));
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  /// Limpa os dados da sessão no estado
  void clearClassroomData() {
    code = null;
    classroomName = null;
    classroomDescription = null;
    isLoaded = false;

    notifyListeners();
  }
}
