import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name.snakeCase()}}_state.freezed.dart';

@freezed
sealed class {{name.pascalCase()}}State with _${{name.pascalCase()}}State {
  const factory {{name.pascalCase()}}State.initial() = InitialState;
  const factory {{name.pascalCase()}}State.loading() = LoadingState;
  const factory {{name.pascalCase()}}State.success() = SuccessState;
  const factory {{name.pascalCase()}}State.failure(String message) = FailureState;
}
