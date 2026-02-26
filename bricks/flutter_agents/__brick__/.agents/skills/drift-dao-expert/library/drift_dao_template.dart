// [STRICT_TEMPLATE]: DRIFT_DAO
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../tables.dart';

part '@{{name}}_dao.g.dart';

@DriftAccessor(tables: [@{{Name}}s])
class @{{Name}}Dao extends DatabaseAccessor<AppDatabase> with _$@{{Name}}Dao {
  @{{Name}}Dao(AppDatabase db) : super(db);

  // GET ALL
  Future<List<@{{Name}}>> getAll() => select(@{{Name}}s).get();

  // WATCH (Stream)
  Stream<List<@{{Name}}>> watchAll() => select(@{{Name}}s).watch();

  // INSERT
  Future<int> insertOne(@{{Name}}sCompanion entity) => into(@{{Name}}s).insert(entity);

  // DELETE
  Future<int> deleteOne(int id) => (delete(@{{Name}}s)..where((t) => t.id.equals(id))).go();
}
