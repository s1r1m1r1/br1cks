import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/repositories/i_{{name.snakeCase()}}_repository.dart';

import '{{name.snakeCase()}}_event.dart';
import '{{name.snakeCase()}}_state.dart';

export '{{name.snakeCase()}}_event.dart';
export '{{name.snakeCase()}}_state.dart';

class {{name.pascalCase()}}Bloc extends Bloc<{{name.pascalCase()}}Event, {{name.pascalCase()}}State> {
  final I{{name.pascalCase()}}Repository _repository;

  {{name.pascalCase()}}Bloc(this._repository) : super(const {{name.pascalCase()}}State.initial()) {
    on<StartedEvent>(_onStarted);
  }

  Future<void> _onStarted(
    StartedEvent event,
    Emitter<{{name.pascalCase()}}State> emit,
  ) async {
    emit(const {{name.pascalCase()}}State.loading());
    try {
      // final data = await _repository.getData();
      emit(const {{name.pascalCase()}}State.success());
    } catch (e) {
      emit({{name.pascalCase()}}State.failure(e.toString()));
    }
  }
}
