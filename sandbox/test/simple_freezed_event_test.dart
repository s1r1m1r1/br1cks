import 'package:mason/mason.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

void main() {
  group('Simple Freezed Event Brick', () {
    late DirectoryGeneratorTarget target;
    late MasonGenerator generator;

    setUp(() async {
      // Путь к вашему кирпичу
      final brick = Brick.path('../bricks/simple_freezed_event');
      generator = await MasonGenerator.fromBrick(brick);
      target = DirectoryGeneratorTarget(Directory.systemTemp.createTempSync());
    });

    test('генерация файлов с правильным неймингом', () async {
      final vars = {'name': 'login_flow'};

      await generator.generate(target, vars: vars);

      // Проверяем физическое наличие файла
      final file = File(p.join(target.dir.path, 'login_flow_event.dart'));
      expect(file.existsSync(), isTrue);

      // print('${file.path}');
      // Проверяем содержимое файла
      final content = file.readAsStringSync();
      expect(content, contains("class LoginFlowEvent"));
      expect(content, contains("part 'login_flow_event.freezed.dart';"));
    });
  });
}
