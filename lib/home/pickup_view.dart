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
    return Scaffold(
      appBar: AppBar(
        title: Text("내 픽업 현황"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Row(
       children: [
         Text('6월 주 ' + subJson.subWeekCount.toString() + '회 구독중'),
         Text('총 ' + subJson.pickupTotalCount.toString() + '중' +
         subJson.pickupCount.toString() + '번 이용했습니다.'),
         Text(subJson.pickupRemainCount.toString() + '번 남았습니다.'),
       ], 
      ),
    );
  }
}
