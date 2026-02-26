import 'dart:io';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('bloc_9', () {
    late MasonGenerator generator;
    late String bricksPath;

    setUpAll(() async {
      // Путь к папке bricks относительно корня проекта br1cks
      // Если запускаем из sandbox, то это ../bricks
      bricksPath = p.canonicalize(
        p.join(Directory.current.path, '..', 'bricks'),
      );
      final bloc9Path = p.join(bricksPath, 'bloc_9');

      final brick = Brick.path(bloc9Path);
      generator = await MasonGenerator.fromBrick(brick);
    });

    test('generates all 3 files in the feature directory', () async {
      final tempDir = Directory.systemTemp.createTempSync('bloc_9_test_');
      final target = DirectoryGeneratorTarget(tempDir);

      final vars = <String, dynamic>{'name': 'profile'};

      // Выполняем pre_gen hook
      await generator.hooks.preGen(
        vars: vars,
        workingDirectory: tempDir.path,
        onVarsChanged: (newVars) => vars.addAll(newVars),
      );

      // Генерируем основной кирпич
      await generator.generate(target, vars: vars);

      final featureDir = p.join(tempDir.path, 'profile');

      // Проверяем наличие файлов
      expect(
        File(p.join(featureDir, 'profile_bloc.dart')).existsSync(),
        isTrue,
        reason: 'profile_bloc.dart should exist',
      );
      expect(
        File(p.join(featureDir, 'profile_event.dart')).existsSync(),
        isTrue,
        reason: 'profile_event.dart should exist',
      );
      expect(
        File(p.join(featureDir, 'profile_state.dart')).existsSync(),
        isTrue,
        reason: 'profile_state.dart should exist',
      );

      // Очистка
      tempDir.deleteSync(recursive: true);
    });
  });
}
