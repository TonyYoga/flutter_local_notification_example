import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TestPage1 extends StatelessWidget {
    static const String tag='TestPage1';
    static const String path = '/test_page_1';

    final String data = Get.arguments;

  @override
  Widget build(BuildContext context) {
//    print('=======> $data');
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Page 1'),
            Text(data),
            FlatButton(
              onPressed: Get.back,
              child: Text('go back'),
            )
          ],
        ),
      ),
    );
  }
}
