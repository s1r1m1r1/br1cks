import 'dart:io';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('agent_bloc_expert', () {
    late String bricksPath;

    setUpAll(() async {
      bricksPath = p.canonicalize(
        p.join(Directory.current.path, '..', 'bricks'),
      );
    });

    test('generates agent skill structure correctly', () async {
      final tempDir = Directory.systemTemp.createTempSync('agent_skill_test_');
      final target = DirectoryGeneratorTarget(tempDir);
      final brick = Brick.path(p.join(bricksPath, 'agent_bloc_expert'));
      final generator = await MasonGenerator.fromBrick(brick);

      final vars = <String, dynamic>{};

      // Run hooks
      await generator.hooks.preGen(
        vars: vars,
        onVarsChanged: (newVars) => vars.addAll(newVars),
      );

      await generator.generate(target, vars: vars);

      final skillDir = p.join(tempDir.path, '.agents', 'skills', 'bloc-expert');
      final scriptDir = p.join(skillDir, 'scripts');
      final libraryDir = p.join(tempDir.path, '.agents', 'skills', 'library');

      expect(File(p.join(skillDir, 'SKILL.md')).existsSync(), isTrue);
      expect(File(p.join(scriptDir, 'gen_bloc.sh')).existsSync(), isTrue);
      expect(
        File(p.join(libraryDir, 'bloc_template.dart')).existsSync(),
        isTrue,
      );

      final templateContent = File(
        p.join(libraryDir, 'bloc_template.dart'),
      ).readAsStringSync();

      // Проверяем, что плейсхолдеры {{name}} сохранились в итоговом файле для агента
      expect(templateContent, contains("part '{{name}}_bloc.freezed.dart';"));
      expect(
        templateContent,
        contains(
          "class {{Name}}Bloc extends Bloc<{{Name}}Event, {{Name}}State>",
        ),
      );

      tempDir.deleteSync(recursive: true);
    });
  });
}
