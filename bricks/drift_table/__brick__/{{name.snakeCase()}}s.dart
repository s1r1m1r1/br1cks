import 'package:drift/drift.dart';

class {{name.pascalCase()}}s extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 3, max: 255)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
