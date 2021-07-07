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
      body: Column(
        children: <Widget>[_getFormUI()],
      ),
    );
  }

  Widget _getFormUI() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '7월 주 ' + subJson.subWeekCount.toString() + '회 구독중',
                  style: TextStyle(fontFamily: 'NanumSquare', fontSize: 20),
                ),
                SizedBox(height: 8.0),
                Text('총 ' +
                    subJson.pickupTotalCount.toString() +
                    '번 중 ' +
                    subJson.pickupCount.toString() +
                    '번 이용했습니다.'),
                SizedBox(height: 8.0),
                Text(subJson.pickupRemainCount.toString() + '번 남았습니다.'),
                SizedBox(height: 10.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: _getDataTable(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 팝업
  void pickupTimeAlert(BuildContext context, text) {
    var alert = AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                fontFamily: 'NanumSquare',
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('OK', style: TextStyle(fontFamily: 'NanumSquare')),
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
