import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_feature_event.freezed.dart';

@freezed
sealed class TestFeatureEvent with _$TestFeatureEvent {
  const factory TestFeatureEvent.started() = StartedEvent;
}
