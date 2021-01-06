// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'create_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$CreateProfileStateTearOff {
  const _$CreateProfileStateTearOff();

// ignore: unused_element
  _NotSubmitted notSubmitted() {
    return const _NotSubmitted();
  }

// ignore: unused_element
  _Error error(String errorText) {
    return _Error(
      errorText,
    );
  }

// ignore: unused_element
  _Loading loading() {
    return const _Loading();
  }

// ignore: unused_element
  _Success success() {
    return const _Success();
  }
}

/// @nodoc
// ignore: unused_element
const $CreateProfileState = _$CreateProfileStateTearOff();

/// @nodoc
mixin _$CreateProfileState {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult notSubmitted(),
    @required TResult error(String errorText),
    @required TResult loading(),
    @required TResult success(),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult notSubmitted(),
    TResult error(String errorText),
    TResult loading(),
    TResult success(),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult notSubmitted(_NotSubmitted value),
    @required TResult error(_Error value),
    @required TResult loading(_Loading value),
    @required TResult success(_Success value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult notSubmitted(_NotSubmitted value),
    TResult error(_Error value),
    TResult loading(_Loading value),
    TResult success(_Success value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $CreateProfileStateCopyWith<$Res> {
  factory $CreateProfileStateCopyWith(
          CreateProfileState value, $Res Function(CreateProfileState) then) =
      _$CreateProfileStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$CreateProfileStateCopyWithImpl<$Res>
    implements $CreateProfileStateCopyWith<$Res> {
  _$CreateProfileStateCopyWithImpl(this._value, this._then);

  final CreateProfileState _value;
  // ignore: unused_field
  final $Res Function(CreateProfileState) _then;
}

/// @nodoc
abstract class _$NotSubmittedCopyWith<$Res> {
  factory _$NotSubmittedCopyWith(
          _NotSubmitted value, $Res Function(_NotSubmitted) then) =
      __$NotSubmittedCopyWithImpl<$Res>;
}

/// @nodoc
class __$NotSubmittedCopyWithImpl<$Res>
    extends _$CreateProfileStateCopyWithImpl<$Res>
    implements _$NotSubmittedCopyWith<$Res> {
  __$NotSubmittedCopyWithImpl(
      _NotSubmitted _value, $Res Function(_NotSubmitted) _then)
      : super(_value, (v) => _then(v as _NotSubmitted));

  @override
  _NotSubmitted get _value => super._value as _NotSubmitted;
}

/// @nodoc
class _$_NotSubmitted implements _NotSubmitted {
  const _$_NotSubmitted();

  @override
  String toString() {
    return 'CreateProfileState.notSubmitted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _NotSubmitted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult notSubmitted(),
    @required TResult error(String errorText),
    @required TResult loading(),
    @required TResult success(),
  }) {
    assert(notSubmitted != null);
    assert(error != null);
    assert(loading != null);
    assert(success != null);
    return notSubmitted();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult notSubmitted(),
    TResult error(String errorText),
    TResult loading(),
    TResult success(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (notSubmitted != null) {
      return notSubmitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult notSubmitted(_NotSubmitted value),
    @required TResult error(_Error value),
    @required TResult loading(_Loading value),
    @required TResult success(_Success value),
  }) {
    assert(notSubmitted != null);
    assert(error != null);
    assert(loading != null);
    assert(success != null);
    return notSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult notSubmitted(_NotSubmitted value),
    TResult error(_Error value),
    TResult loading(_Loading value),
    TResult success(_Success value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (notSubmitted != null) {
      return notSubmitted(this);
    }
    return orElse();
  }
}

abstract class _NotSubmitted implements CreateProfileState {
  const factory _NotSubmitted() = _$_NotSubmitted;
}

/// @nodoc
abstract class _$ErrorCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) then) =
      __$ErrorCopyWithImpl<$Res>;
  $Res call({String errorText});
}

/// @nodoc
class __$ErrorCopyWithImpl<$Res> extends _$CreateProfileStateCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(_Error _value, $Res Function(_Error) _then)
      : super(_value, (v) => _then(v as _Error));

  @override
  _Error get _value => super._value as _Error;

  @override
  $Res call({
    Object errorText = freezed,
  }) {
    return _then(_Error(
      errorText == freezed ? _value.errorText : errorText as String,
    ));
  }
}

/// @nodoc
class _$_Error implements _Error {
  const _$_Error(this.errorText) : assert(errorText != null);

  @override
  final String errorText;

  @override
  String toString() {
    return 'CreateProfileState.error(errorText: $errorText)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Error &&
            (identical(other.errorText, errorText) ||
                const DeepCollectionEquality()
                    .equals(other.errorText, errorText)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(errorText);

  @override
  _$ErrorCopyWith<_Error> get copyWith =>
      __$ErrorCopyWithImpl<_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult notSubmitted(),
    @required TResult error(String errorText),
    @required TResult loading(),
    @required TResult success(),
  }) {
    assert(notSubmitted != null);
    assert(error != null);
    assert(loading != null);
    assert(success != null);
    return error(errorText);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult notSubmitted(),
    TResult error(String errorText),
    TResult loading(),
    TResult success(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(errorText);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult notSubmitted(_NotSubmitted value),
    @required TResult error(_Error value),
    @required TResult loading(_Loading value),
    @required TResult success(_Success value),
  }) {
    assert(notSubmitted != null);
    assert(error != null);
    assert(loading != null);
    assert(success != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult notSubmitted(_NotSubmitted value),
    TResult error(_Error value),
    TResult loading(_Loading value),
    TResult success(_Success value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements CreateProfileState {
  const factory _Error(String errorText) = _$_Error;

  String get errorText;
  _$ErrorCopyWith<_Error> get copyWith;
}

/// @nodoc
abstract class _$LoadingCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res>
    extends _$CreateProfileStateCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(_Loading _value, $Res Function(_Loading) _then)
      : super(_value, (v) => _then(v as _Loading));

  @override
  _Loading get _value => super._value as _Loading;
}

/// @nodoc
class _$_Loading implements _Loading {
  const _$_Loading();

  @override
  String toString() {
    return 'CreateProfileState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult notSubmitted(),
    @required TResult error(String errorText),
    @required TResult loading(),
    @required TResult success(),
  }) {
    assert(notSubmitted != null);
    assert(error != null);
    assert(loading != null);
    assert(success != null);
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult notSubmitted(),
    TResult error(String errorText),
    TResult loading(),
    TResult success(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult notSubmitted(_NotSubmitted value),
    @required TResult error(_Error value),
    @required TResult loading(_Loading value),
    @required TResult success(_Success value),
  }) {
    assert(notSubmitted != null);
    assert(error != null);
    assert(loading != null);
    assert(success != null);
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult notSubmitted(_NotSubmitted value),
    TResult error(_Error value),
    TResult loading(_Loading value),
    TResult success(_Success value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements CreateProfileState {
  const factory _Loading() = _$_Loading;
}

/// @nodoc
abstract class _$SuccessCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) then) =
      __$SuccessCopyWithImpl<$Res>;
}

/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    extends _$CreateProfileStateCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(_Success _value, $Res Function(_Success) _then)
      : super(_value, (v) => _then(v as _Success));

  @override
  _Success get _value => super._value as _Success;
}

/// @nodoc
class _$_Success implements _Success {
  const _$_Success();

  @override
  String toString() {
    return 'CreateProfileState.success()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Success);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult notSubmitted(),
    @required TResult error(String errorText),
    @required TResult loading(),
    @required TResult success(),
  }) {
    assert(notSubmitted != null);
    assert(error != null);
    assert(loading != null);
    assert(success != null);
    return success();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult notSubmitted(),
    TResult error(String errorText),
    TResult loading(),
    TResult success(),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult notSubmitted(_NotSubmitted value),
    @required TResult error(_Error value),
    @required TResult loading(_Loading value),
    @required TResult success(_Success value),
  }) {
    assert(notSubmitted != null);
    assert(error != null);
    assert(loading != null);
    assert(success != null);
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult notSubmitted(_NotSubmitted value),
    TResult error(_Error value),
    TResult loading(_Loading value),
    TResult success(_Success value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements CreateProfileState {
  const factory _Success() = _$_Success;
}
