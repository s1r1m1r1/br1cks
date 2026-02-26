// [STRICT_TEMPLATE]: BLOC_SINGLE_FILE
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '@{{name}}_bloc.freezed.dart';

@freezed
sealed class @{{Name}}Event with _$@{{Name}}Event {
  const factory @{{Name}}Event.started() = _StartedEvent;
  const factory @{{Name}}Event.loading() = _StartedEvent;
}

@freezed
sealed class @{{Name}}State with _$@{{Name}}State {
  const factory @{{Name}}State.initial() = InitialState;
  const factory @{{Name}}State.loading() = LoadingState;
  const factory @{{Name}}State.success({required dynamic data}) = SuccessState;
  const factory @{{Name}}State.failure(String message) = FailureState;
}

class @{{Name}}Bloc extends Bloc<@{{Name}}Event, @{{Name}}State> {
  final @{{Name}}Repository _repository;
  @{{Name}}Bloc(this._repository) : super(const @{{Name}}State.initial()) {
    on<_Started>(_onStarted);
  }

  Future<void> _onStarted(_Started event, Emitter<@{{Name}}State> emit) async {
    emit(const @{{Name}}State.loading());
    try{
      final result = await _repository.getData();
      emit(const @{{Name}}State.success(data: 'data'));
    } on TimeoutException catch (e) {
      emit(@{{Name}}State.failure('timeout'));
    } 
    catch (error,stack) {
      emit(@{{Name}}State.failure(e.toString()));
      rethrow;
    }
  }
}
