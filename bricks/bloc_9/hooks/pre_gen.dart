import 'dart:io';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as p;

Future<void> run(HookContext context) async {
  final name = context.vars['name'] as String;
  final featureName = name.snakeCase;

  // Определяем целевую директорию (текущая папка/имя_фичи)
  final targetDirectory = Directory(
    p.join(Directory.current.path, featureName),
  );
  final target = DirectoryGeneratorTarget(targetDirectory);

  // Список кирпичей для последовательной генерации
  final subBricks = [
    {'name': 'simple_freezed_event', 'var': 'event'},
    {'name': 'sealed_freezed_state', 'var': 'state'},
  ];

  for (final brickInfo in subBricks) {
    final progress = context.logger.progress('Generating ${brickInfo['name']}');

    // ВАЖНО: Brick.path должен указывать на местоположение микро-бриков
    final bricksDir = context.vars['bricks_dir'] ?? '..';
    final brick = Brick.path(
      p.join(bricksDir as String, brickInfo['name'] as String),
    );
    final generator = await MasonGenerator.fromBrick(brick);

    // Генерируем микро-брик
    await generator.generate(
      target,
      vars: {'name': featureName},
      logger: context.logger,
      fileConflictResolution: FileConflictResolution.overwrite,
    );

    progress.complete('Generated ${brickInfo['name']}');
  }

  // Передаем переменные в основной шаблон bloc_9 (в __brick__)
  context.vars = {
    ...context.vars,
    'event_import': '${featureName}_event.dart',
    'state_import': '${featureName}_state.dart',
    'feature_path': featureName,
  };
}

// Future<void> run(HookContext context) async {
//   final style = context.vars['style'];
//   context.vars = {
//     ...context.vars,
//     'use_basic': style == 'basic',
//     'use_equatable': style == 'equatable',
//     'use_freezed': style == 'freezed',
//   };
// }
