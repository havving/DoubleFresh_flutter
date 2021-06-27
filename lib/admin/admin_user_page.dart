import 'dart:convert';

import 'package:double_fresh/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdminUserPage();
}

class _AdminUserPage extends State<StatefulWidget> {

  late List<String> headingRow;
  late Iterable list;
  late List<dynamic> jsonList;
  var fromJson = [];

  final _adminUserInfoUrl = Uri.parse('http://192.168.0.22:3000/admin/user_info');

  Future<void> getInfo() async {
    http.Response _res = await http.get(_adminUserInfoUrl);
    jsonList = jsonDecode(_res.body);
    for (var i in jsonList) {
      fromJson.add(User.fromJson(i));
    }
    print(fromJson);
  }

  @override
  void initState() {
    super.initState();
    headingRow = ['ID', '이름', '휴대폰번호', '구독 여부', '구독 횟수', '총 픽업 횟수', '픽업 횟수', '남은 픽업 횟수', '요청사항'];
    getInfo();
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
    List<DataRow> dataRow = [];
    List<DataCell> cells = [];

    for (var i in headingRow) {
      cells.add(DataCell(Text('-')));
    }
    dataRow.add(DataRow(cells: cells));

    return dataRow;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: Scaffold(
        appBar: AppBar(
          title: Text('사용자 관리'),
        ),
        body: Column(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: _getDataTable(),
              )
            )
          ],
        ),
      ),
    );
  }
}
