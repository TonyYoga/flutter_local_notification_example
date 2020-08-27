import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  NotificationAppLaunchDetails get notificationAppLounchDetails => _details;

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
    var notificationAppStartDetails = await _flutterLocalNotificationsPlugin
        .getNotificationAppLaunchDetails();
    dev.log(
        '{"did start from Notification" : "${notificationAppStartDetails.didNotificationLaunchApp}", '
        '"payload": "${notificationAppStartDetails.payload}"}');

    if (payload != null) {
      dev.log('{"payload" : "$payload"}',
          name: 'onSelectNotification',
          error: {"data": "Error date or other data"});
    }
    Get.toNamed(payload, arguments: payload);
    //Navigator here can be
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

  void showNotification() async {
    await _notification();
  }

  void showNotificationAfterFewSec(String payload) async {
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

  Future<void> _notification() async {
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
      payload: 'payload 12',
    );
  }

  Future<void> _notificationAfterFewSec(String payload) async {
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
      'Notification $payload',
      'body text',
      timeDelayed,
      notificationDetails,
      payload: payload,
    );
  }

  Future<void> notificationPeriod(String payload) async {
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
        payload: payload);
  }
}
