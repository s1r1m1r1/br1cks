// [STRICT_TEMPLATE]: DRIFT_DATABASE_DART
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'database.g.dart';

// --- TABLE DEFINITION ---
class @s extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// --- DAO CLASS ---
@DriftAccessor(tables: [@s])
class @Dao extends DatabaseAccessor<AppDatabase> with _$@DaoMixin {
  @Dao(AppDatabase db) : super(db);
}

// --- DATABASE CLASS ---
@DriftDatabase(tables: [@s], daos: [@Dao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(NativeDatabase.memory()); // Replace with actual file connection

  @override
  int get schemaVersion => 1;
  
  // Queries
  Future<List<@>> getAll@s() => select(@s).get();
}
