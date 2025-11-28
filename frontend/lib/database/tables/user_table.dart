import 'package:drift/drift.dart';

class User extends Table {
  TextColumn get id => text()();
  TextColumn get email => text()();
  TextColumn get username => text()();
  TextColumn get userType => text()();
  BoolColumn get hasMfa => boolean().withDefault(const Constant(false))();
  TextColumn get access => text()();
  TextColumn get refresh => text()();

  @override
  Set<Column> get primaryKey => {id};
}
