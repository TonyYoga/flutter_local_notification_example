import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notification/core/model/notification_payload.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:developer' as dev;

import 'package:get/get.dart';

class LocalNotificationService {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings _androidInitializationSettings;
  IOSInitializationSettings _iosInitializationSettings;
  InitializationSettings _initializationSettings;
  NotificationAppLaunchDetails _details;

  FlutterLocalNotificationsPlugin get notificationPlugin =>
      _flutterLocalNotificationsPlugin;

  NotificationAppLaunchDetails get notificationAppLaunchDetails => _details;

  LocalNotificationService() {
    _initializing();
  }

  void _initializing() async {
    _androidInitializationSettings = AndroidInitializationSettings('app_icon');
    _iosInitializationSettings = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    _initializationSettings = InitializationSettings(
        _androidInitializationSettings, _iosInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(_initializationSettings,
        onSelectNotification: onSelectNotification);
    _details = await _flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails();
  }

  Future<void> onSelectNotification(String payload) async {
    dev.log(
      '{$payload}',
      name: 'onSelectNotification',
    );
    if (payload == null || payload.isEmpty) {
      dev.log('payload must be not null or empty', name: 'onSelectNotification');
      return;
    }
    var payloadMap = NotificationPayload.fromJson(json.decode(payload));
    if(payloadMap.path == null || payloadMap.path.isEmpty) {
      dev.log('Path is empty or null', name: 'onSelectNotification');
      return;
    }
    Get.toNamed(payloadMap.path, arguments: payloadMap.path);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        CupertinoDialogAction(
          child: Text('Ok'),
          isDefaultAction: true,
          onPressed: () {
            print('dialog onPress');
          },
        )
      ],
    );
  }

  void showNotification(NotificationPayload payload) async {
    await _notification(payload);
  }

  void showNotificationAfterFewSec(NotificationPayload payload) async {
    await _notificationAfterFewSec(payload);
  }

  Future<List<PendingNotificationRequest>> pendingNotificationRequest() async {
    var pendingNotifications =
        await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return pendingNotifications;
  }

  void cleanAllNotificationRequest() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  void removeNotificationById(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> _notification(NotificationPayload payload) async {
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'Channel ID',
      'Channel title',
      'channel body',
      priority: Priority.High,
      importance: Importance.Max,
      ticker: 'test',
      color: Colors.orange,
    );
    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(
      0,
      'Hello there',
      'message text',
      notificationDetails,
      payload: json.encode(payload.toJson()),
    );
  }

  Future<void> _notificationAfterFewSec(NotificationPayload payload) async {
    var timeDelayed = DateTime.now().add(Duration(seconds: 10));
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'second channel ID',
      'second channel title',
      'second channel body',
      priority: Priority.High,
      importance: Importance.Max,
      ticker: 'test',
    );
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await _flutterLocalNotificationsPlugin.schedule(
      new Random().nextInt(10),
      'Notification ${payload.path}',
      'body text',
      timeDelayed,
      notificationDetails,
      payload: json.encode(payload.toJson()),
    );
  }

  Future<void> notificationPeriod(NotificationPayload payload) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'second channel ID',
      'second channel title',
      'second channel body',
      priority: Priority.High,
      importance: Importance.Max,
      ticker: 'test',
    );
    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    NotificationDetails notificationDetails =
        NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await _flutterLocalNotificationsPlugin.periodicallyShow(
      new Random().nextInt(10),
      'Periodically title',
      'Periodically body',
      RepeatInterval.EveryMinute,
      notificationDetails,
      payload: json.encode(payload.toJson()),
    );
  }
}
