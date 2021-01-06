import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_profile_state.freezed.dart';

@freezed
abstract class CreateProfileState with _$CreateProfileState {
  const factory CreateProfileState.notSubmitted() = _NotSubmitted;
  const factory CreateProfileState.error(String errorText) = _Error;
  const factory CreateProfileState.loading() = _Loading;
  const factory CreateProfileState.success() = _Success;
}
