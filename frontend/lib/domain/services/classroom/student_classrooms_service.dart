import 'package:blindds_app/data/repository/classroom/student_classrooms_repository.dart';
import 'package:blindds_app/domain/entities/classroom_entity.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:dio/dio.dart';

class StudentClassroomsService {
  final StudentClassroomsRepository _repository;

  StudentClassroomsService({required StudentClassroomsRepository repository})
    : _repository = repository;

  Future<List<ClassroomEntity>> getStudentClassrooms() async {
    try {
      return await _repository.getStudentClassrooms();
    } on DioException catch (error) {
      throw DioErrorHelper.handle(error);
    } catch (error) {
      throw GenericErrorHelper.handle(error);
    }
  }
}
