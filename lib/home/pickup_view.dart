import 'package:double_fresh/model/subscription.dart';
import 'package:flutter/material.dart';

class PickupViewPage extends StatefulWidget {
  Subscription subJson;

  PickupViewPage(this.subJson);

  @override
  State<StatefulWidget> createState() => _PickupView(subJson: subJson);
}

class _PickupView extends State<StatefulWidget> {
  late Subscription subJson;

  _PickupView({required this.subJson});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: Scaffold(
        appBar: AppBar(
          title: Text('내 픽업 현황'),
        ),
        body: Center(
          child: Text(''),
        ),
      ),
    );
  }
}
