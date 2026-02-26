import 'package:drift/drift.dart';
import '{{name.snakeCase()}}_database.dart';
import 'key_value_table.dart';

part 'key_value_dao.g.dart';

@DriftAccessor(tables: [KeyValueTable])
class KeyValueDao extends DatabaseAccessor<{{name.pascalCase()}}Database> with _$KeyValueDao {
  KeyValueDao({{name.pascalCase()}}Database db) : super(db);

  // Method to save a key-value pair
  Future<void> save(String key, String value) {
    return into(keyValueTable).insertOnConflictUpdate(
      KeyValueTableCompanion.insert(key: key, value: value),
    );
  }

  // Method to retrieve a value by key
  Future<String?> get(String key) async {
    final result = await (select(keyValueTable)..where((t) => t.key.equals(key))).getSingleOrNull();
    return result?.value;
  }

  // Method to delete a key-value pair
  Future<void> delete(String key) {
    return (delete(keyValueTable)..where((t) => t.key.equals(key))).go();
  }
}
