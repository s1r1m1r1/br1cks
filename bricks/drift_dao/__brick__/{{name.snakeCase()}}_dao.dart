import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../tables.dart';

part '{{name.snakeCase()}}_dao.g.dart';

@DriftAccessor(tables: [{{name.pascalCase()}}s])
class {{name.pascalCase()}}Dao extends DatabaseAccessor<AppDatabase> with _${{name.pascalCase()}}Dao {
  {{name.pascalCase()}}Dao(AppDatabase db) : super(db);

  // GET ALL
  Future<List<{{name.pascalCase()}}>> getAll() => select({{name.pascalCase()}}s).get();

  // WATCH (Stream)
  Stream<List<{{name.pascalCase()}}>> watchAll() => select({{name.pascalCase()}}s).watch();

  // INSERT
  Future<int> insertOne({{name.pascalCase()}}sCompanion entity) => into({{name.pascalCase()}}s).insert(entity);

  // DELETE
  Future<int> deleteOne(int id) => (delete({{name.pascalCase()}}s)..where((t) => t.id.equals(id))).go();
}
