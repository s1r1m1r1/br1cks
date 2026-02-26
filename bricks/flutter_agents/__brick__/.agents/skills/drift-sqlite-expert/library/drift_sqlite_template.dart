// [STRICT_TEMPLATE]: DRIFT_DATABASE_DART
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'database.g.dart';

// --- TABLE DEFINITION ---
class @{{Name}}s extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// --- DAO CLASS ---
@DriftAccessor(tables: [@{{Name}}s])
class @{{Name}}Dao extends DatabaseAccessor<AppDatabase> with _$@{{Name}}DaoMixin {
  @{{Name}}Dao(AppDatabase db) : super(db);
}

// --- DATABASE CLASS ---
@DriftDatabase(tables: [@{{Name}}s], daos: [@{{Name}}Dao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(NativeDatabase.memory()); // Replace with actual file connection

  @override
  int get schemaVersion => 1;
  
  // Queries
  Future<List<@{{Name}}>> getAll@{{Name}}s() => select(@{{Name}}s).get();
}
