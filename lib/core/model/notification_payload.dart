
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_payload.freezed.dart';
part 'notification_payload.g.dart';


@freezed
abstract class NotificationPayload with _$NotificationPayload {
  const factory NotificationPayload({String path}) = _NotificationPayload;
  factory NotificationPayload.fromJson(Map<String, dynamic> json) =>
      _$NotificationPayloadFromJson(json);
}