import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name.snakeCase()}}_state.freezed.dart';

@freezed
sealed class {{name.pascalCase()}}State with _${{name.pascalCase()}}State {
  /// Начальное состояние
  const factory {{name.pascalCase()}}State.initial() = InitialState;

  /// Состояние загрузки
  const factory {{name.pascalCase()}}State.loading() = LoadingState;

  /// Состояние с данными
  const factory {{name.pascalCase()}}State.success({
    @Default('') String message,
  }) = SuccessState;

  /// Состояние ошибки
  const factory {{name.pascalCase()}}State.failure([String? error]) = FailureState;
}