import 'package:blindds_app/data/datasources/local/classroom/classroom_local_datasource.dart';
import 'package:blindds_app/data/datasources/remote/classroom/validate_code_remote_datasource.dart';
import 'package:blindds_app/domain/entities/classroom_entity.dart';

class ValidateCodeRepository {
  final ValidateCodeDataSource _remoteDataSource;
  final ClassroomLocalDataSource _localDataSource;

  ValidateCodeRepository({
    required ValidateCodeDataSource remoteDataSource,
    required ClassroomLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

Future<ClassroomEntity> verifyClassroomCode({required String code}) async {

  final rawData = await _remoteDataSource.validateCode(code: code); 
  final classroomJson = rawData.data['classroom'];
  final classroomEntity = ClassroomEntity.fromJson(classroomJson);

  await _localDataSource.saveClassroom(
    classroom: classroomEntity
  );

  return classroomEntity;
}


}