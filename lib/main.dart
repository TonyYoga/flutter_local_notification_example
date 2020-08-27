import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notification/core/app/get_routes.dart';
import 'package:flutter_local_notification/pages/test_notification_list.dart';
import 'package:flutter_local_notification/pages/test_page_1.dart';
import 'package:flutter_local_notification/pages/test_page_2.dart';
import 'package:flutter_local_notification/services/local_notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  LocalNotificationService _service;
  NotificationAppLaunchDetails ifStartFromNotification;


  @override
  void initState() {
    super.initState();
    _service = LocalNotificationService();
    _getStartAppDetails();
  }

  _getStartAppDetails() {
    ifStartFromNotification = _service.notificationAppLounchDetails;
//    print(ifStartFromNotification.didNotificationLaunchApp);
  }


  @override
  Widget build(BuildContext context) {
    var initRoute = ifStartFromNotification != null ?
    ifStartFromNotification.didNotificationLaunchApp ?
    ifStartFromNotification.payload : '/' : '/';

    return GetMaterialApp(
      home: LocalNotification(service: _service, startDetails: ifStartFromNotification,),
      getPages: pages,
      initialRoute: initRoute,
    );
  }
}

class LocalNotification extends StatelessWidget {
  static const String path = '/local_notification_list';

  final LocalNotificationService service;
  final NotificationAppLaunchDetails startDetails;

  const LocalNotification({Key key, this.service, this.startDetails}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Notification & Get'),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            startDetails != null ?
            Text('From notification ${startDetails.didNotificationLaunchApp} '
                '${startDetails.payload}') : Container(),
            FlatButton(
              color: Colors.blue,
              onPressed: service.showNotification,
              child: Text(
                'Show notification',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: () => service.showNotificationAfterFewSec(TestPage1.path),
              child: Text(
                'Show notification after few seconds, route to page 1',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: () => service.showNotificationAfterFewSec(TestPage2.path),
              child: Text(
                'Show notification after few seconds, route to page 2',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: () => service.notificationPeriod(TestPage1.path),
              child: Text(
                'Show notification every minute',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: () => Get.to(TestNotificationList(
                data: service.pendingNotificationRequest(),
                onDelete: service.removeNotificationById,
              )),
              child: Text(
                'Show notification list',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: () => service.cleanAllNotificationRequest(),
              child: Text(
                'Clear notification queue',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
            FlatButton(
              color: Colors.indigoAccent,
              onPressed: () => Get.toNamed(TestPage1.path, arguments: TestPage1.tag),
              child: Text(
                'Tes getNamedRoutes-> page 1',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
