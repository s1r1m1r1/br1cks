import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/repositories/i_test_feature_repository.dart';

import 'test_feature_event.dart';
import 'test_feature_state.dart';

export 'test_feature_event.dart';
export 'test_feature_state.dart';

class TestFeatureBloc extends Bloc<TestFeatureEvent, TestFeatureState> {
  final ITestFeatureRepository _repository;

  TestFeatureBloc(this._repository) : super(const TestFeatureState.initial()) {
    on<StartedEvent>(_onStarted);
  }

  Future<void> _onStarted(
    StartedEvent event,
    Emitter<TestFeatureState> emit,
  ) async {
    emit(const TestFeatureState.loading());
    try {
      // final data = await _repository.getData();
      emit(const TestFeatureState.success());
    } catch (e) {
      emit(TestFeatureState.failure(e.toString()));
    }
  }
}
