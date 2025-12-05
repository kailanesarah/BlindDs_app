import 'package:blindds_app/data/repository/classroom/classroom_repository.dart';
import 'package:blindds_app/domain/entities/classroom_entity.dart';
import 'package:blindds_app/utils/helpers/dio_error_helper.dart';
import 'package:blindds_app/utils/helpers/generic_error_helper.dart';
import 'package:dio/dio.dart';

class ClassroomService {
  final ClassroomRepository _repository;

  ClassroomService({required ClassroomRepository repository})
    : _repository = repository;

  Future<ClassroomEntity?> getClassroom(String classroomId) async {
    try {
      return await _repository.getClassroom(classroomId);
    } on DioException catch (error) {
      throw DioErrorHelper.handle(error);
    } catch (error) {
      throw GenericErrorHelper.handle(error);
    }
  }
}
