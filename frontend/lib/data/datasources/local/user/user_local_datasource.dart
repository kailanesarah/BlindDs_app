import 'package:blindds_app/data/datasources/local/app_database.dart';
import 'package:blindds_app/domain/entities/user_entity.dart';
import 'package:drift/drift.dart';

class UserLocalDataSource {
  final AppDatabase db;

  UserLocalDataSource(this.db);

  Future<void> saveUser(UserEntity user) async {
    await db.delete(db.user).go();

    await db
        .into(db.user)
        .insert(
          UserCompanion(
            id: Value(user.id),
            username: Value(user.username),
            email: Value(user.email),
            userType: Value(user.userType), 
            access: Value(user.accessToken),
            refresh: Value(user.refreshToken),
          ),
        );
  }

  Future<UserEntity?> getUser() async {
    final users = await db.select(db.user).get();

    if (users.isEmpty) return null;

    return UserEntity.fromDrift(users.last);
  }

  Future<void> updateTokens({required String access, String? refresh}) async {
    final users = await db.select(db.user).get();
    if (users.isEmpty) return;

    final user = users.last;

    await (db.update(db.user)..where((tbl) => tbl.id.equals(user.id))).write(
      UserCompanion(
        access: Value(access),
        refresh: Value(refresh ?? user.refresh),
      ),
    );
  }

  Future<String?> getAccessToken() async {
    final users = await db.select(db.user).get();
    if (users.isEmpty) return null;
    return users.last.access;
  }

  Future<String?> getRefreshToken() async {
    final users = await db.select(db.user).get();
    if (users.isEmpty) return null;
    return users.last.refresh;
  }

  Future<void> clear() async {
    await db.delete(db.user).go();
  }
}
