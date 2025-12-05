import 'package:blindds_app/data/datasources/local/app_database.dart';
import 'package:blindds_app/domain/entities/classroom_entity.dart';
import 'package:drift/drift.dart';

class ClassroomLocalDataSource {
  final AppDatabase db;

  ClassroomLocalDataSource(this.db);

  /// Salva ou atualiza uma sala individual no banco local.
  Future<void> saveClassroom({required ClassroomEntity classroom}) async {
    await db
        .into(db.classroom)
        .insertOnConflictUpdate(
          ClassroomCompanion(
            id: Value(classroom.id),
            code: Value(classroom.code),
            name: Value(classroom.name),
            description: Value(classroom.description),
            createdAt: Value(classroom.createdAt),
            updatedAt: Value(classroom.updatedAt),
          ),
        );
  }

  /// Salva uma lista de salas, limpando os registros antigos antes.
  Future<void> saveClassrooms({
    required List<ClassroomEntity> classrooms,
  }) async {
    await clear(); // Limpa registros antigos
    for (final classroom in classrooms) {
      await saveClassroom(classroom: classroom);
    }
  }

  /// Retorna todas as salas armazenadas localmente.
  Future<List<ClassroomEntity>> getClassrooms() async {
    final data = await db.select(db.classroom).get();
    return data.map((item) => ClassroomEntity.fromDrift(item)).toList();
  }

  /// Retorna a primeira sala armazenada, ou null se não houver.
  Future<ClassroomEntity?> getClassroom() async {
    final data = await db.select(db.classroom).getSingleOrNull();
    return data != null ? ClassroomEntity.fromDrift(data) : null;
  }

  /// Retorna uma sala específica pelo seu ID, ou null se não encontrada.
  Future<ClassroomEntity?> getClassroomById(String id) async {
    final data = await (db.select(
      db.classroom,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return data != null ? ClassroomEntity.fromDrift(data) : null;
  }

  /// Limpa todas as salas armazenadas localmente.
  Future<void> clear() async {
    await db.delete(db.classroom).go();
  }
}
