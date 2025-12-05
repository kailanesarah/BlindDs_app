import 'package:drift/drift.dart';

class User extends Table {
  TextColumn get id => text()();
  TextColumn get email => text()();
  TextColumn get username => text()();

  TextColumn get userType => text().named('user_type')();
  BoolColumn get hasMfa =>
      boolean().named('has_mfa').withDefault(const Constant(false))();

  TextColumn get access => text()();
  TextColumn get refresh => text()();

  @override
  Set<Column> get primaryKey => {id};
}
