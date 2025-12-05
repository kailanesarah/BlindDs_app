import 'package:blindds_app/data/datasources/local/classroom/classroom_local_datasource.dart';
import 'package:blindds_app/data/datasources/remote/classroom/classroom_remote_datasource.dart';
import 'package:blindds_app/domain/entities/classroom_entity.dart';

class ClassroomRepository {
  final ClassroomRemoteDataSource _remoteDataSource;
  final ClassroomLocalDataSource _localDataSource;

  ClassroomRepository({
    required ClassroomRemoteDataSource remoteDataSource,
    required ClassroomLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  Future<ClassroomEntity?> getClassroom(String classroomId) async {
    // Tenta carregar do local
    final localClassroom = await _localDataSource.getClassroomById(classroomId);
    if (localClassroom != null) {
      return localClassroom;
    }

    // Se não encontrar localmente, busca do remoto
    final response = await _remoteDataSource.getClassroom(classroomId);
    final data = response.data;

    if (data == null || data.isEmpty) {
      return null;
    }

    // Converte para entidade
    final classroom = ClassroomEntity.fromJson(data);
    return classroom;
  }
}
