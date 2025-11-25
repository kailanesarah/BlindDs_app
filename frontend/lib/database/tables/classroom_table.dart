import 'package:drift/drift.dart';

class Classroom extends Table {
  TextColumn get id => text()(); 
  TextColumn get code => text()(); 
  TextColumn get name => text()(); 
  TextColumn get description => text()(); 
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id}; 
}
