import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final name = context.vars['name'] as String;
  final featureName = name.snakeCase;

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
