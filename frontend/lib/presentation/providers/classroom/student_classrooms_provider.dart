import 'package:blindds_app/domain/entities/classroom_entity.dart';
import 'package:blindds_app/domain/services/classroom/student_classrooms_service.dart';
import 'package:blindds_app/utils/base_provider.dart';

class StudentClassroomsProvider extends BaseProvider {
  final StudentClassroomsService _service;

  StudentClassroomsProvider({required StudentClassroomsService service})
    : _service = service;

  List<ClassroomEntity> _classrooms = [];
  List<ClassroomEntity> get classrooms => _classrooms;

  bool get hasClassrooms => _classrooms.isNotEmpty;

  Future<void> loadClassrooms() async {
    setLoading(true);
    clearError();

    try {
      final result = await _service.getStudentClassrooms();
      _classrooms = result;
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
