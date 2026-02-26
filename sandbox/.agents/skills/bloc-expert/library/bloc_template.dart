// [STRICT_TEMPLATE]: BLOC_SINGLE_FILE
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '@_bloc.freezed.dart';

@freezed
sealed class @Event with _$@Event {
  const factory @Event.started() = _StartedEvent;
  const factory @Event.loading() = _StartedEvent;
}

@freezed
sealed class @State with _$@State {
  const factory @State.initial() = InitialState;
  const factory @State.loading() = LoadingState;
  const factory @State.success({required dynamic data}) = SuccessState;
  const factory @State.failure(String message) = FailureState;
}

class @Bloc extends Bloc<@Event, @State> {
  final @Repository _repository;
  @Bloc(this._repository) : super(const @State.initial()) {
    on<_Started>(_onStarted);
  }

  Future<void> _onStarted(_Started event, Emitter<@State> emit) async {
    emit(const @State.loading());
    try{
      final result = await _repository.getData();
      emit(const @State.success(data: 'data'));
    } on TimeoutException catch (e) {
      emit(@State.failure('timeout'));
    } 
    catch (error,stack) {
      emit(@State.failure(e.toString()));
      rethrow;
    }
  }
}
