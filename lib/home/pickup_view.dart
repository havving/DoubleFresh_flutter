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
      body: Column(
        children: <Widget>[
          Text('6월 주 ' + subJson.subWeekCount.toString() + '회 구독중'),
          Text('총 ' +
              subJson.pickupTotalCount.toString() +
              '중' +
              subJson.pickupCount.toString() +
              '번 이용했습니다.'),
          Text(subJson.pickupRemainCount.toString() + '번 남았습니다.'),
          DataTable(
            columns: [
              DataColumn(label: Text('샐러드')),
              DataColumn(label: Text('예약 날짜')),
              DataColumn(label: Text('예약 시간')),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('A1')),
                DataCell(Text('B1')),
                DataCell(Text('B1')),
              ]),
              DataRow(cells: [
                DataCell(Text('A2')),
                DataCell(Text('B2')),
                DataCell(Text('B2')),
              ]),
            ],
          )
        ],
      ),
    );
  }
}
