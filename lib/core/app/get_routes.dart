
import 'package:flutter_local_notification/main.dart';
import 'package:flutter_local_notification/pages/test_notification_list.dart';
import 'package:flutter_local_notification/pages/test_page_1.dart';
import 'package:flutter_local_notification/pages/test_page_2.dart';
import 'package:get/get.dart';

List<GetPage> pages = [
  GetPage(name: LocalNotification.path, page: () => LocalNotification()),
  GetPage(name: '/', page: () => LocalNotification()),
  GetPage(name: TestNotificationList.path, page: () => TestNotificationList()),
  GetPage(name: TestPage1.path, page: () => TestPage1()),
  GetPage(name: TestPage2.path, page: () => TestPage2()),
];