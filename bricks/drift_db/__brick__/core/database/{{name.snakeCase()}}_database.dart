import 'package:drift/drift.dart';
import 'key_value_table.dart';
import 'key_value_dao.dart';

// Import for openConnection (should be implemented in your project)
// import 'connection/native.dart' if (dart.library.html) 'connection/web.dart';

part '{{name.snakeCase()}}_database.g.dart';

@DriftDatabase(
  tables: [KeyValueTable],
  daos: [KeyValueDao],
)
class {{name.pascalCase()}}Database extends _${{name.pascalCase()}}Database {
  {{name.pascalCase()}}Database([QueryExecutor? executor]) 
      : super(executor ?? openConnection()); // openConnection() must be defined elsewhere

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) {
      return m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 1) {
        await m.createAll();
      }
    },
    beforeOpen: (details) async {
      // Make sure that foreign keys are enabled
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

// Dummy openConnection to avoid compile errors in template, 
// though the user should provide a real one.
QueryExecutor openConnection() => throw UnimplementedError('Implement openConnection()');
