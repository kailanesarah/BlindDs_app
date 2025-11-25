import 'package:blindds_app/database/app_database.dart';
import 'package:drift/drift.dart';

class ClassroomLocalDataSource {
  final AppDatabase db;

  ClassroomLocalDataSource(this.db);

  Future<void> saveClassroom({
    required String code,
    required String name,
    required String description,
    required String id,
  }) async {
    await db.into(db.classroom).insertOnConflictUpdate(
      ClassroomCompanion(
        code: Value(code),
        name: Value(name),
        description: Value(description),
        id: Value(id),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<Map<String, dynamic>> getClassroom() async {
    final classroom = await db.select(db.classroom).getSingleOrNull();
    if (classroom == null) return {};
    return {
      'id': classroom.id,
      'code': classroom.code,
      'name': classroom.name,
      'description': classroom.description,
      'createdAt': classroom.createdAt.toIso8601String(),
      'updatedAt': classroom.updatedAt.toIso8601String(),
    };
  }

  /// Limpa os dados da sala
  Future<void> clear() async {
    await db.delete(db.classroom).go();
  }
}
