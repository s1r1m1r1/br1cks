// [STRICT_TEMPLATE]: BLOC_SINGLE_FILE
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '{{lb}}name{{rb}}_bloc.freezed.dart';

@freezed
sealed class {{lb}}Name{{rb}}Event with _${{lb}}Name{{rb}}Event {
  const factory {{lb}}Name{{rb}}Event.started() = _Started;
}

@freezed
sealed class {{lb}}Name{{rb}}State with _${{lb}}Name{{rb}}State {
  const factory {{lb}}Name{{rb}}State.initial() = _Initial;
  const factory {{lb}}Name{{rb}}State.loading() = _Loading;
  const factory {{lb}}Name{{rb}}State.success({required dynamic data}) = _Success;
  const factory {{lb}}Name{{rb}}State.failure(String message) = _Failure;
}

class {{lb}}Name{{rb}}Bloc extends Bloc<{{lb}}Name{{rb}}Event, {{lb}}Name{{rb}}State> {
  final {{lb}}Name{{rb}}Repository _repository;
  
  {{lb}}Name{{rb}}Bloc(this._repository) : super(const {{lb}}Name{{rb}}State.initial()) {
    on<_Started>(_onStarted);
  }

  Future<void> _onStarted(_Started event, Emitter<{{lb}}Name{{rb}}State> emit) async {
    emit(const {{lb}}Name{{rb}}State.loading());
    try {
      final result = await _repository.getData();
      emit({{lb}}Name{{rb}}State.success(data: result));
    } on TimeoutException catch (_) {
      emit(const {{lb}}Name{{rb}}State.failure('timeout'));
    } catch (e) {
      emit({{lb}}Name{{rb}}State.failure(e.toString()));
      rethrow;
    }
  }
}
