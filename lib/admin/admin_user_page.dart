import 'dart:convert';

import 'package:double_fresh/model/admin_user.dart';
import 'package:double_fresh/model/subscription_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'admin_user_add_dialog.dart';
import 'admin_user_dialog.dart';

class AdminUserPage extends StatefulWidget {
  List<dynamic> jsonList;

  AdminUserPage(this.jsonList);

  @override
  State<StatefulWidget> createState() => _AdminUserPage(jsonList: jsonList);
}

class _AdminUserPage extends State<StatefulWidget> {
  late List<String> headingRow;
  late List<dynamic> jsonList;
  var fromJson = [];

  int selectedIndex = -1;

  final _adminUserInfoUrl = 'http://192.168.0.22:3000/admin/user_info_detail/';
  final _adminUserDelUrl = 'http://192.168.0.22:3000/admin/user_delete/';

  _AdminUserPage({required this.jsonList});

  @override
  void initState() {
    super.initState();
    headingRow = ['번호', '   ID', '이름', '  휴대폰번호', '구독 여부', '상세정보'];
    for (var i in jsonList) {
      fromJson.add(AdminUser.fromJson(i));
    }
  }

  /// 표 데이터 값
  Widget _getDataTable() {
    return DataTable(
      onSelectAll: (val) {
        setState(() {
          selectedIndex = -1;
        });
      },
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
          label: Text(
        i,
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: 'NanumSquare'),
      )));
    }
    return dataColumn;
  }

  /// rows
  List<DataRow> _getRows() {
    List<DataRow> dataRow = [];

    for (var i = 0; i < fromJson.length; i++) {
      List<DataCell> cells = [];
      cells.add(DataCell(Text(
        (i + 1).toString(),
        style: TextStyle(fontFamily: 'NanumSquare'),
      )));
      cells.add(DataCell(Text(
        fromJson[i].id.toString(),
        style: TextStyle(fontFamily: 'NanumSquare'),
      )));
      cells.add(DataCell(Text(
        fromJson[i].name,
        style: TextStyle(fontFamily: 'NanumSquare'),
      )));
      cells.add(DataCell(Text(
        fromJson[i].phone.toString(),
        style: TextStyle(fontFamily: 'NanumSquare'),
      )));
      cells.add(DataCell(Text(
        fromJson[i].status == 'Y' ? 'O' : 'X',
        style: TextStyle(fontFamily: 'NanumSquare'),
      )));
      cells.add(DataCell(Icon(Icons.open_in_new), onTap: () async {
        var url = _adminUserInfoUrl + fromJson[i].id.toString();
        http.Response _res = await http.get(Uri.parse(url));
        Map<String, dynamic> jsonMap = jsonDecode(_res.body);
        var subJson = Subscription_Detail.fromJson(jsonMap);

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) {
              return AdminUserDialog(fromJson[i].id, fromJson[i].name, subJson);
            });
      }));

      dataRow.add(DataRow(
          cells: cells,
          selected: i == selectedIndex,
          onSelectChanged: (val) {
            setState(() {
              selectedIndex = i;
            });
            print('row ' + i.toString());
          }));
    }

    return dataRow;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.teal, fontFamily: 'NanumSquare'),
      home: Scaffold(
        appBar: AppBar(
          title: Text('구독자 관리'),
        ),
        body: Column(
          children: <Widget>[
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: _getDataTable(),
                )),
            SizedBox(height: 30.0),
            ButtonBar(
              children: <Widget>[
                MaterialButton(
                    child: Text(
                      '구독자 추가',
                      style: TextStyle(fontFamily: 'NanumSquare'),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.cyan[800],
                    minWidth: 100, height: 50,
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) {
                            return AdminUserAddDialog();
                          });
                    }),
                MaterialButton(
                    child: Text(
                      '구독자 삭제',
                      style: TextStyle(fontFamily: 'NanumSquare'),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.cyan[800],
                    minWidth: 100, height: 50,
                    onPressed: () async {}),
              ],
            )
          ],
        ),
      ),
    );
  }
}
