import 'package:mason/mason.dart';
import 'package:mason/mason.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

void main() {
  group('Sealed Freezed State Brick', () {
    late DirectoryGeneratorTarget target;
    late MasonGenerator generator;

    setUp(() async {
      // Путь к кирпичу state (убедись, что папка называется именно так)
      final brick = Brick.path('../bricks/sealed_freezed_state');
      generator = await MasonGenerator.fromBrick(brick);
      target = DirectoryGeneratorTarget(Directory.systemTemp.createTempSync());
    });

    test('генерация State с правильным неймингом и sealed классом', () async {
      final vars = {'name': 'auth_profile'};

      await generator.generate(target, vars: vars);

      // 1. Проверяем наличие файла с суффиксом _state
      final file = File(p.join(target.dir.path, 'auth_profile_state.dart'));
      expect(
        file.existsSync(),
        isTrue,
        reason: 'Файл state должен быть создан',
      );

      final content = file.readAsStringSync();

      // 2. Проверяем корректность названий классов и аннотаций
      expect(content, contains("sealed class AuthProfileState"));
      expect(content, contains("with _\$AuthProfileState"));

      // 3. Проверяем корректность part-файла
      expect(content, contains("part 'auth_profile_state.freezed.dart';"));

      // 4. Проверяем наличие базовых состояний (на основе нашего шаблона)
      expect(
        content,
        contains("factory AuthProfileState.initial() = InitialState;"),
      );
      expect(
        content,
        contains("factory AuthProfileState.loading() = LoadingState;"),
      );
    });
  });
}
