import 'package:blindds_app/data/datasources/local/app_database.dart';

class ClassroomEntity {
  final String id;
  final String code;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  ClassroomEntity({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return 'ClassroomEntity(id: $id, name: $name, description: $description,  created_at: $createdAt, updated_at: $updatedAt)';
  }

  factory ClassroomEntity.fromJson(json) {
    return ClassroomEntity(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  factory ClassroomEntity.fromDrift(ClassroomData data) {
    return ClassroomEntity(
      id: data.id,
      code: data.code,
      name: data.name,
      description: data.description,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }
}
