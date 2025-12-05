import 'package:blindds_app/domain/services/classroom/student_classrooms_service.dart';
import 'package:blindds_app/utils/base_provider.dart';

class StudentClassroomsDecisionProvider extends BaseProvider {
  final StudentClassroomsService _service;

  bool? hasClassrooms;
  String? error;

  StudentClassroomsDecisionProvider({required StudentClassroomsService service})
    : _service = service;

  Future<void> decide() async {
    setLoading(true);
    clearError();

    try {
      final result = await _service.getStudentClassrooms();
      hasClassrooms = result.isNotEmpty;
    } catch (e) {
      error = e.toString();
      hasClassrooms = false;
    } finally {
      setLoading(false);
    }
  }

  @override
  void clearError() {
    error = null;
  }
}
