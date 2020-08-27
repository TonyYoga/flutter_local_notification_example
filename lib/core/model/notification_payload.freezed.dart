// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'notification_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
NotificationPayload _$NotificationPayloadFromJson(Map<String, dynamic> json) {
  return _NotificationPayload.fromJson(json);
}

class _$NotificationPayloadTearOff {
  const _$NotificationPayloadTearOff();

// ignore: unused_element
  _NotificationPayload call({String path}) {
    return _NotificationPayload(
      path: path,
    );
  }
}

// ignore: unused_element
const $NotificationPayload = _$NotificationPayloadTearOff();

mixin _$NotificationPayload {
  String get path;

  Map<String, dynamic> toJson();
  $NotificationPayloadCopyWith<NotificationPayload> get copyWith;
}

abstract class $NotificationPayloadCopyWith<$Res> {
  factory $NotificationPayloadCopyWith(
          NotificationPayload value, $Res Function(NotificationPayload) then) =
      _$NotificationPayloadCopyWithImpl<$Res>;
  $Res call({String path});
}

class _$NotificationPayloadCopyWithImpl<$Res>
    implements $NotificationPayloadCopyWith<$Res> {
  _$NotificationPayloadCopyWithImpl(this._value, this._then);

  final NotificationPayload _value;
  // ignore: unused_field
  final $Res Function(NotificationPayload) _then;

  @override
  $Res call({
    Object path = freezed,
  }) {
    return _then(_value.copyWith(
      path: path == freezed ? _value.path : path as String,
    ));
  }
}

abstract class _$NotificationPayloadCopyWith<$Res>
    implements $NotificationPayloadCopyWith<$Res> {
  factory _$NotificationPayloadCopyWith(_NotificationPayload value,
          $Res Function(_NotificationPayload) then) =
      __$NotificationPayloadCopyWithImpl<$Res>;
  @override
  $Res call({String path});
}

class __$NotificationPayloadCopyWithImpl<$Res>
    extends _$NotificationPayloadCopyWithImpl<$Res>
    implements _$NotificationPayloadCopyWith<$Res> {
  __$NotificationPayloadCopyWithImpl(
      _NotificationPayload _value, $Res Function(_NotificationPayload) _then)
      : super(_value, (v) => _then(v as _NotificationPayload));

  @override
  _NotificationPayload get _value => super._value as _NotificationPayload;

  @override
  $Res call({
    Object path = freezed,
  }) {
    return _then(_NotificationPayload(
      path: path == freezed ? _value.path : path as String,
    ));
  }
}

@JsonSerializable()
class _$_NotificationPayload implements _NotificationPayload {
  const _$_NotificationPayload({this.path});

  factory _$_NotificationPayload.fromJson(Map<String, dynamic> json) =>
      _$_$_NotificationPayloadFromJson(json);

  @override
  final String path;

  @override
  String toString() {
    return 'NotificationPayload(path: $path)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _NotificationPayload &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(path);

  @override
  _$NotificationPayloadCopyWith<_NotificationPayload> get copyWith =>
      __$NotificationPayloadCopyWithImpl<_NotificationPayload>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_NotificationPayloadToJson(this);
  }
}

abstract class _NotificationPayload implements NotificationPayload {
  const factory _NotificationPayload({String path}) = _$_NotificationPayload;

  factory _NotificationPayload.fromJson(Map<String, dynamic> json) =
      _$_NotificationPayload.fromJson;

  @override
  String get path;
  @override
  _$NotificationPayloadCopyWith<_NotificationPayload> get copyWith;
}
