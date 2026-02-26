import 'dart:io';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('drift bricks', () {
    late String bricksPath;

    setUpAll(() async {
      bricksPath = p.canonicalize(
        p.join(Directory.current.path, '..', 'bricks'),
      );
    });

    test('drift_table generates table file', () async {
      final tempDir = Directory.systemTemp.createTempSync('drift_table_test_');
      final target = DirectoryGeneratorTarget(tempDir);
      final brick = Brick.path(p.join(bricksPath, 'drift_table'));
      final generator = await MasonGenerator.fromBrick(brick);

      await generator.generate(target, vars: {'name': 'task'});

      expect(File(p.join(tempDir.path, 'tasks.dart')).existsSync(), isTrue);
      tempDir.deleteSync(recursive: true);
    });

    test('drift_dao generates dao file', () async {
      final tempDir = Directory.systemTemp.createTempSync('drift_dao_test_');
      final target = DirectoryGeneratorTarget(tempDir);
      final brick = Brick.path(p.join(bricksPath, 'drift_dao'));
      final generator = await MasonGenerator.fromBrick(brick);

      await generator.generate(target, vars: {'name': 'task'});

      expect(File(p.join(tempDir.path, 'task_dao.dart')).existsSync(), isTrue);
      tempDir.deleteSync(recursive: true);
    });

    test('drift_feature generates feature structure', () async {
      final tempDir = Directory.systemTemp.createTempSync(
        'drift_feature_test_',
      );
      final target = DirectoryGeneratorTarget(tempDir);
      final brick = Brick.path(p.join(bricksPath, 'drift_feature'));
      final generator = await MasonGenerator.fromBrick(brick);

      await generator.generate(target, vars: {'name': 'profile'});

      final dataPath = p.join(tempDir.path, 'features', 'profile', 'data');
      expect(File(p.join(dataPath, 'tables.dart')).existsSync(), isTrue);
      expect(File(p.join(dataPath, 'profile_dao.dart')).existsSync(), isTrue);

      final daoContent = File(
        p.join(dataPath, 'profile_dao.dart'),
      ).readAsStringSync();
      expect(daoContent, contains("import 'tables.dart';"));
      expect(
        daoContent,
        contains("class ProfileDao extends DatabaseAccessor<AppDatabase>"),
      );

      tempDir.deleteSync(recursive: true);
    });
    test('drift_db generates database structure', () async {
      final tempDir = Directory.systemTemp.createTempSync('drift_db_test_');
      final target = DirectoryGeneratorTarget(tempDir);
      final brick = Brick.path(p.join(bricksPath, 'drift_db'));
      final generator = await MasonGenerator.fromBrick(brick);

      await generator.generate(target, vars: {'name': 'app'});

      final dbPath = p.join(tempDir.path, 'core', 'database');
      expect(File(p.join(dbPath, 'app_database.dart')).existsSync(), isTrue);
      expect(File(p.join(dbPath, 'key_value_table.dart')).existsSync(), isTrue);
      expect(File(p.join(dbPath, 'key_value_dao.dart')).existsSync(), isTrue);

      final daoContent = File(
        p.join(dbPath, 'key_value_dao.dart'),
      ).readAsStringSync();
      expect(
        daoContent,
        contains("class KeyValueDao extends DatabaseAccessor<AppDatabase>"),
      );
      expect(
        daoContent,
        contains("Future<void> save(String key, String value)"),
      );
      expect(daoContent, contains("Future<String?> get(String key)"));

      tempDir.deleteSync(recursive: true);
    });
  });
}
