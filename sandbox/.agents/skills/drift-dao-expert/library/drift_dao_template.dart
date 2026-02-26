// [STRICT_TEMPLATE]: DRIFT_DAO
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart';
import '../tables.dart';

part '@_dao.g.dart';

@DriftAccessor(tables: [@s])
class @Dao extends DatabaseAccessor<AppDatabase> with _$@Dao {
  @Dao(AppDatabase db) : super(db);

  // GET ALL
  Future<List<@>> getAll() => select(@s).get();

  // WATCH (Stream)
  Stream<List<@>> watchAll() => select(@s).watch();

  // INSERT
  Future<int> insertOne(@sCompanion entity) => into(@s).insert(entity);

  // DELETE
  Future<int> deleteOne(int id) => (delete(@s)..where((t) => t.id.equals(id))).go();
}
