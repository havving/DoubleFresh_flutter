import 'dart:convert';

import 'package:double_fresh/model/pickup_info.dart';
import 'package:double_fresh/model/subscription.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PickupViewPage extends StatefulWidget {
  Subscription subJson;

  PickupViewPage(this.subJson);

  @override
  State<StatefulWidget> createState() => _PickupView(subJson: subJson);
}

class _PickupView extends State<StatefulWidget> {
  _PickupView({required this.subJson});

  late Subscription subJson;
  late List<String> headingRow;
  late List<PickupInfo> pickupList;
  late Iterable list;
  late String _selectedTime;

  final _pickupCancelUrl = Uri.parse('http://192.168.0.22:3000/pickup_cancel');
  final _pickupTimeModifyUrl =
      Uri.parse('http://192.168.0.22:3000/pickup_time_modify');

  @override
  void initState() {
    super.initState();
    headingRow = ['번호', '샐러드', '날짜', '예약시간', '수정', '취소'];
    list = subJson.pickupInfo;
    pickupList = list.map((e) => PickupInfo.fromJson(e)).toList();
  }

  /// 표 데이터 값
  Widget _getDataTable() {
    return DataTable(
      horizontalMargin: 12.0,
      columnSpacing: 28.0,
      columns: _getColumns(),
      rows: _getRows(),
    );
  }

  /// columns
  List<DataColumn> _getColumns() {
    List<DataColumn> dataColumn = [];
    for (var i in headingRow) {
      dataColumn.add(DataColumn(
          label: Center(child: Text(i, textAlign: TextAlign.center))));
    }
    return dataColumn;
  }

  /// rows
  List<DataRow> _getRows() {
    List<DataCell> cells = [];
    List<DataRow> dataRow = [];
    if (pickupList.length > 0) {
      for (var i = 0; i < pickupList.length; i++) {
        List<DataCell> cells = [];
        cells.add(
            DataCell(Text((i + 1).toString(), textAlign: TextAlign.center)));
        cells.add(DataCell(Text(pickupList[i].salad)));
        cells.add(DataCell(
            Text(pickupList[i].day.toString(), textAlign: TextAlign.center)));
        cells.add(
            DataCell(Text(pickupList[i].time, textAlign: TextAlign.center)));
        cells.add(DataCell(Icon(Icons.access_alarm), onTap: () async {
          Future<TimeOfDay?> selectedTime = showTimePicker(
            initialTime: TimeOfDay.now(),
            context: context,
          );
          selectedTime.then((time) async {
            setState(() {
              _selectedTime = '${time!.hour}:${time.minute}';
            });
            var data = {
              "id": subJson.id,
              "day": pickupList[i].day,
              "time": _selectedTime,
            };
            var body = json.encode(data);
            http.Response _res = await http.put(_pickupTimeModifyUrl,
                headers: {
                  "Content-Type": "application/json",
                  "Access-Control-Allow-Origin": "*"
                },
                body: body);
            pickupTimeAlert(context, _res.body);
          });
        }));
        cells.add(DataCell(Icon(Icons.cancel_outlined), onTap: () async {
          var data = {
            "id": subJson.id,
            "day": pickupList[i].day,
          };
          var body = json.encode(data);
          http.Response _res = await http.delete(_pickupCancelUrl,
              headers: {
                "Content-Type": "application/json",
                "Access-Control-Allow-Origin": "*"
              },
              body: body);
          pickupTimeAlert(context, _res.body);
        }));
        dataRow.add(DataRow(cells: cells));
      }
    } else {
      for (var i in headingRow) {
        cells.add(DataCell(Text('-')));
      }
      dataRow.add(DataRow(cells: cells));
    }

    return dataRow;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("내 픽업 현황"),
          backgroundColor: Colors.lightGreen,
        ),
        body: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text(
                "7월 ",
                style: new TextStyle(
                    fontSize: 28.0,
                    color: const Color(0xFF00ae3c),
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "주 ",
                style: new TextStyle(
                    fontSize: 28.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "2",
                style: new TextStyle(
                    fontSize: 28.0,
                    color: const Color(0xFFae4d00),
                    fontWeight: FontWeight.w700),
              ),
              new Text(
                "회 ",
                style: new TextStyle(
                    fontSize: 28.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w600),
              ),
              new Text(
                "구독 중",
                style: new TextStyle(
                    fontSize: 28.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200),
              )
            ])

        /*Column(
        children: <Widget>[
          Text('7월 주 ' + subJson.subWeekCount.toString() + '회 구독중'),
          Text('총 ' +
              subJson.pickupTotalCount.toString() +
              '번 중 ' +
              subJson.pickupCount.toString() +
              '번 이용했습니다.'),
          Text(subJson.pickupRemainCount.toString() + '번 남았습니다.'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: _getDataTable(),
            ),
          ),
        ],
      ),*/
        );
  }

  /// 팝업
  void pickupTimeAlert(BuildContext context, text) {
    var alert = AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[Text(text)],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(/*result*/);
          },
        ),
      ],
    );

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
