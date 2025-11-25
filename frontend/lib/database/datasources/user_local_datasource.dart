import 'package:blindds_app/database/app_database.dart';
import 'package:drift/drift.dart';

class UserLocalDataSource {
  final AppDatabase db;

  UserLocalDataSource(this.db);

  // ============================================================
  //  🔥 Salva o usuário garantindo que exista APENAS 1 registro
  // ============================================================
  Future<void> saveUser({
    required String id,
    required String name,
    required String email,
    required String userType,
    required String access,
    required String refresh,
  }) async {
    // Apaga qualquer usuário existente para evitar duplicação
    await db.delete(db.user).go();

    // Insere o novo usuário
    await db.into(db.user).insert(
      UserCompanion(
        id: Value(id),
        username: Value(name),
        email: Value(email),
        userType: Value(userType),
        access: Value(access),
        refresh: Value(refresh),
      ),
    );
  }

  // ============================================================
  //  🔥 Atualiza apenas os tokens do usuário salvo
  // ============================================================
  Future<void> updateTokens({
    required String access,
    String? refresh,
  }) async {
    final users = await db.select(db.user).get();
    if (users.isNotEmpty) {
      final user = users.last;

      await (db.update(db.user)..where((tbl) => tbl.id.equals(user.id))).write(
        UserCompanion(
          access: Value(access),
          refresh: Value(refresh ?? user.refresh),
        ),
      );
    }
  }

  // ============================================================
  //  🔥 Retorna o usuário salvo
  // ============================================================
  Future<Map<String, String?>> getUser() async {
    final users = await db.select(db.user).get();
    if (users.isEmpty) return {};

    final user = users.last;

    return {
      'id': user.id,
      'name': user.username,
      'email': user.email,
      'userType': user.userType,
      'access': user.access,
      'refresh': user.refresh,
    };
  }

  // ============================================================
  //  🔥 Token de acesso (seguro, sem crash)
  // ============================================================
  Future<String?> getAccessToken() async {
    final users = await db.select(db.user).get();
    if (users.isEmpty) return null;
    return users.last.access;
  }

  // ============================================================
  //  🔥 Token de refresh (seguro, sem crash)
  // ============================================================
  Future<String?> getRefreshToken() async {
    final users = await db.select(db.user).get();
    if (users.isEmpty) return null;
    return users.last.refresh;
  }

  // ============================================================
  //  🔥 Limpa login local
  // ============================================================
  Future<void> clear() async {
    await db.delete(db.user).go();
  }
}
