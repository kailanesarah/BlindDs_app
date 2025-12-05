import 'package:blindds_app/data/datasources/local/classroom/classroom_local_datasource.dart';
import 'package:blindds_app/data/datasources/remote/classroom/student_classrooms_remote_datasource.dart';
import 'package:blindds_app/domain/entities/classroom_entity.dart';

class StudentClassroomsRepository {
  final StudentClassroomsRemoteDataSource _remoteDataSource;
  final ClassroomLocalDataSource _localDataSource;

  StudentClassroomsRepository({
    required StudentClassroomsRemoteDataSource remoteDataSource,
    required ClassroomLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  Future<List<ClassroomEntity>> getStudentClassrooms() async {
    //Tenta carregar do LOCAL primeiro
    final localClassrooms = await _localDataSource.getClassrooms();

    if (localClassrooms.isNotEmpty) {
      return localClassrooms;
    }

    //Se não tiver nada no local chama API
    final rawData = await _remoteDataSource.getStudentClassrooms();

    final List<dynamic>? listJson = rawData.data['classrooms'];

    //Se o remoto vier vazio, retorna vazio
    if (listJson == null || listJson.isEmpty) {
      return [];
    }

    //Converte e salva no local
    final classrooms = listJson
        .map((json) => ClassroomEntity.fromJson(json))
        .toList();

    await _localDataSource.saveClassrooms(classrooms: classrooms);

    return classrooms;
  }
}
