import 'package:blindds_app/domain/services/classroom/classroom_service.dart';
import 'package:blindds_app/utils/base_provider.dart';
import 'package:blindds_app/domain/entities/classroom_entity.dart';

class ClassroomProvider extends BaseProvider {
  final ClassroomService _service;

  ClassroomEntity? classroom;

  ClassroomProvider({required ClassroomService service}) : _service = service;

  Future<void> getClassroom(String idClassroom) async {
    setLoading(true);
    clearError();

    try {
      final result = await _service.getClassroom(idClassroom);
      classroom = result;
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }
}
