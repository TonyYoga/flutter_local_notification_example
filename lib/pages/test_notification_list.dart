import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class TestNotificationList extends StatelessWidget {
  static const String tag = 'TestPage1';
  static const String path = '/test_notification_list';

  final Future<List<PendingNotificationRequest>> data;
  final Function onDelete;

  const TestNotificationList({Key key, this.data, this.onDelete}) : super(key: key);


//  @override
//  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//    super.debugFillProperties(properties);
//    properties.add(StringProperty('propertyName', 'I am here', showName: true));
//  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<PendingNotificationRequest>>(
          future: data,
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...snapshot.data.map((e) =>
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e.id.toString()),
                        Text(e.title),
                        Text(e.body),
                        Text(e.payload),
                        FlatButton(onPressed: () => onDelete, child: Icon(Icons.clear))
                      ],
                    ),
                ).toList(),
//                Text('test'),
                FloatingActionButton(
                  onPressed: Get.back,
                  child: Icon(Icons.arrow_back),
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
