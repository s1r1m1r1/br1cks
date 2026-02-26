import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_feature_state.freezed.dart';

@freezed
sealed class TestFeatureState with _$TestFeatureState {
  const factory TestFeatureState.initial() = InitialState;
  const factory TestFeatureState.loading() = LoadingState;
  const factory TestFeatureState.success() = SuccessState;
  const factory TestFeatureState.failure(String message) = FailureState;
}
