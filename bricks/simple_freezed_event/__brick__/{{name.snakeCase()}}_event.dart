import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name.snakeCase()}}_event.freezed.dart';

@freezed
abstract class {{name.pascalCase()}}Event with _${{name.pascalCase()}}Event {
  /// Базовое событие инициализации
  const factory {{name.pascalCase()}}Event.started() = _Started;


}