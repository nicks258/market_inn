// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchState {
  List<SearchItem>? get searchResult => throw _privateConstructorUsedError;
  RequestStatus? get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<SearchItem>? searchResult,
            RequestStatus? status, String? message)
        internal,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<SearchItem>? searchResult, RequestStatus? status,
            String? message)?
        internal,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<SearchItem>? searchResult, RequestStatus? status,
            String? message)?
        internal,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Internal value) internal,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Internal value)? internal,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Internal value)? internal,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchStateCopyWith<SearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
          SearchState value, $Res Function(SearchState) then) =
      _$SearchStateCopyWithImpl<$Res, SearchState>;
  @useResult
  $Res call(
      {List<SearchItem>? searchResult, RequestStatus? status, String? message});
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res, $Val extends SearchState>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchResult = freezed,
    Object? status = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      searchResult: freezed == searchResult
          ? _value.searchResult
          : searchResult // ignore: cast_nullable_to_non_nullable
              as List<SearchItem>?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RequestStatus?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InternalImplCopyWith<$Res>
    implements $SearchStateCopyWith<$Res> {
  factory _$$InternalImplCopyWith(
          _$InternalImpl value, $Res Function(_$InternalImpl) then) =
      __$$InternalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SearchItem>? searchResult, RequestStatus? status, String? message});
}

/// @nodoc
class __$$InternalImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$InternalImpl>
    implements _$$InternalImplCopyWith<$Res> {
  __$$InternalImplCopyWithImpl(
      _$InternalImpl _value, $Res Function(_$InternalImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchResult = freezed,
    Object? status = freezed,
    Object? message = freezed,
  }) {
    return _then(_$InternalImpl(
      searchResult: freezed == searchResult
          ? _value._searchResult
          : searchResult // ignore: cast_nullable_to_non_nullable
              as List<SearchItem>?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RequestStatus?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$InternalImpl implements _Internal {
  const _$InternalImpl(
      {final List<SearchItem>? searchResult = const [],
      this.status = RequestStatus.loading,
      this.message = ''})
      : _searchResult = searchResult;

  final List<SearchItem>? _searchResult;
  @override
  @JsonKey()
  List<SearchItem>? get searchResult {
    final value = _searchResult;
    if (value == null) return null;
    if (_searchResult is EqualUnmodifiableListView) return _searchResult;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final RequestStatus? status;
  @override
  @JsonKey()
  final String? message;

  @override
  String toString() {
    return 'SearchState.internal(searchResult: $searchResult, status: $status, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InternalImpl &&
            const DeepCollectionEquality()
                .equals(other._searchResult, _searchResult) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_searchResult), status, message);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InternalImplCopyWith<_$InternalImpl> get copyWith =>
      __$$InternalImplCopyWithImpl<_$InternalImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<SearchItem>? searchResult,
            RequestStatus? status, String? message)
        internal,
  }) {
    return internal(searchResult, status, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<SearchItem>? searchResult, RequestStatus? status,
            String? message)?
        internal,
  }) {
    return internal?.call(searchResult, status, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<SearchItem>? searchResult, RequestStatus? status,
            String? message)?
        internal,
    required TResult orElse(),
  }) {
    if (internal != null) {
      return internal(searchResult, status, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Internal value) internal,
  }) {
    return internal(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Internal value)? internal,
  }) {
    return internal?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Internal value)? internal,
    required TResult orElse(),
  }) {
    if (internal != null) {
      return internal(this);
    }
    return orElse();
  }
}

abstract class _Internal implements SearchState {
  const factory _Internal(
      {final List<SearchItem>? searchResult,
      final RequestStatus? status,
      final String? message}) = _$InternalImpl;

  @override
  List<SearchItem>? get searchResult;
  @override
  RequestStatus? get status;
  @override
  String? get message;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InternalImplCopyWith<_$InternalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
