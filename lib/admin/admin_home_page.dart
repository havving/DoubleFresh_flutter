import 'package:double_fresh/model/admin_pickup.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  List<dynamic> jsonList;

  AdminHomePage(this.jsonList);

  @override
  State<StatefulWidget> createState() => _AdminHomePage(jsonList: jsonList);
}

class _AdminHomePage extends State<StatefulWidget> {
  late List<String> headingRow;
  late List<dynamic> jsonList;
  var fromJson = [];

  _AdminHomePage({required this.jsonList});

  // TODO 꼭 DataTable로 해야할까?
  // TODO 캘린더 라이브러리로 할 수 있지 않을까? <- 찾아보기

  @override
  void initState() {
    super.initState();
    headingRow = [
      '번호',
      '이름',
      '예약시간',
      '요청사항',
    ];
    for (var i in jsonList) {
      fromJson.add(AdminPickup.fromJson(i));
    }
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
      dataColumn.add(DataColumn(label: Text(i)));
    }
    return dataColumn;
  }

  /// rows
  List<DataRow> _getRows() {
    List<DataCell> cells = [];
    List<DataRow> dataRow = [];

    if (fromJson.length > 0) {
      for (var i = 0; i < fromJson.length; i++) {
        List<DataCell> cells = [];
        cells.add(DataCell(Text((i + 1).toString())));
        cells.add(DataCell(Text(fromJson[i].name)));
        cells.add(DataCell(Text(fromJson[i].time)));
        cells.add(DataCell(Text(fromJson[i].request)));

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
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: Scaffold(
        appBar: AppBar(
          title: Text('픽업 관리'),
        ),
        body: Column(
          children: <Widget>[
            Text('오늘의 픽업 현황'),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: _getDataTable(),
                )),
          ],
        )
      ),
    );
  }
}