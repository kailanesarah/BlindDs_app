import 'package:blindds_app/data/datasources/local/app_database.dart';
import 'package:blindds_app/domain/entities/classroom_entity.dart';
import 'package:drift/drift.dart';

class ClassroomLocalDataSource {
  final AppDatabase db;

  ClassroomLocalDataSource(this.db);

  Future<void> saveClassroom({
    required ClassroomEntity classroom,
  }) async {
    await db.into(db.classroom).insertOnConflictUpdate(
      ClassroomCompanion(
        id: Value(classroom.id),
        code: Value(classroom.code),
        name: Value(classroom.name),
        description: Value(classroom.description),
        createdAt: Value(classroom.createdAt),
        updatedAt: Value(classroom.createdAt),
      ),
    );
  }

  Future<ClassroomEntity?> getClassroom() async {
    final data = await db.select(db.classroom).getSingleOrNull();
    return data != null ? ClassroomEntity.fromDrift(data) : null;
  }

  Future<void> clear() async {
    await db.delete(db.classroom).go();
  }

  Future<ClassroomEntity?> getClassroomById(String id) async {
    final data = await (db.select(db.classroom)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();

    return data != null ? ClassroomEntity.fromDrift(data) : null;
  }
}
