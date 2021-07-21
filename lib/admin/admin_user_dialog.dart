import 'package:double_fresh/model/subscription_detail.dart';
import 'package:flutter/material.dart';

class AdminUserDialog extends StatefulWidget {
  int id;
  String name;

  Subscription_Detail subJson;

  AdminUserDialog(this.id, this.name, this.subJson);

  @override
  State<StatefulWidget> createState() =>
      _AdminUserState(id: id, name: name, subJson: subJson);
}

class _AdminUserState extends State<StatefulWidget> {
  var id, name;

  late Subscription_Detail subJson;
  late List<String> headingRow;

  _AdminUserState(
      {required this.id, required this.name, required this.subJson});

  @override
  void initState() {
    super.initState();
    headingRow = ['구독 횟수', '총 구독 횟수', '총 픽업 횟수', '남은 픽업 횟수', '요청사항'];
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
          label: Text(
        i,
        style: TextStyle(fontFamily: 'NanumSquare'),
      )));
    }
    return dataColumn;
  }

  /// rows
  List<DataRow> _getRows() {
    List<DataRow> dataRow = [];
    List<DataCell> cells = [];

    cells.add(DataCell(Text(
      subJson.subWeekCount.toString(),
      style: TextStyle(fontFamily: 'NanumSquare'),
    )));
    cells.add(DataCell(Text(
      subJson.pickupTotalCount.toString(),
      style: TextStyle(fontFamily: 'NanumSquare'),
    )));
    cells.add(DataCell(Text(
      subJson.pickupCount.toString(),
      style: TextStyle(fontFamily: 'NanumSquare'),
    )));
    cells.add(DataCell(Text(
      subJson.pickupRemainCount.toString(),
      style: TextStyle(fontFamily: 'NanumSquare'),
    )));
    cells.add(DataCell(Text(subJson.request)));

    dataRow.add(DataRow(cells: cells));

    return dataRow;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(name + "(" + id.toString() + ")",
          style: TextStyle(fontFamily: 'NanumSquare')),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Scrollbar(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: _getDataTable(),
                    ))),
          ],
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          child: Text('닫기', style: TextStyle(fontFamily: 'NanumSquare')),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
