import 'dart:convert';

import 'package:calendar_strip/calendar_strip.dart';
import 'package:double_fresh/model/admin_pickup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  var fromList = [];

  final _adminPickupUrl = 'http://192.168.0.22:3000/admin/pickup/';

  _AdminHomePage({required this.jsonList});

  /// Calendar
  DateTime startDate = DateTime.now().subtract(Duration(days: 8));
  DateTime endDate = DateTime.now().add(Duration(days: 8));
  DateTime selectedDate = DateTime.now().subtract(Duration(days: 0));

  onSelect(data) async {
    print("Selected Date -> $data");
    var url = _adminPickupUrl + data.day.toString();
    http.Response _res = await http.get(Uri.parse(url));
    jsonList = jsonDecode(_res.body);

    if (jsonList.length > 0) {
      for (var i in jsonList) {
        fromList.clear();
        fromList.add(AdminPickup.fromJson(i));
      }
    } else fromList.clear();
    // TODO 왜 setState()하면 날짜가 선택이 안되는지?
    setState(() {
      fromJson = fromList;
      _getDataTable();
    });
  }

  onWeekSelect(data) {
    print("Selected week starting at -> $data");
  }

  _monthNameWidget(monthName) {
    return Container(
      child: Text(
        monthName,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
          fontStyle: FontStyle.italic,
        ),
      ),
      padding: EdgeInsets.only(top: 8, bottom: 4),
    );
  }

  dateTileBuilder(
      date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.black87;
    TextStyle normalStyle =
        TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: fontColor);
    TextStyle selectedStyle = TextStyle(
        fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87);
    TextStyle dayNameStyle = TextStyle(fontSize: 14.5, color: fontColor);
    List<Widget> _children = [
      Text(dayName, style: dayNameStyle),
      Text(date.day.toString(),
          style: !isSelectedDate ? normalStyle : selectedStyle),
    ];

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color: !isSelectedDate ? Colors.transparent : Colors.white70,
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
      child: Column(
        children: _children,
      ),
    );
  }

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
        body: Row(
          children: <Widget>[
            Expanded(
                child: Column(
              children: <Widget>[
                Container(
                    child: CalendarStrip(
                  startDate: startDate,
                  endDate: endDate,
                  selectedDate: selectedDate,
                  onDateSelected: onSelect,
                  onWeekSelected: onWeekSelect,
                  dateTileBuilder: dateTileBuilder,
                  iconColor: Colors.black87,
                  monthNameWidget: _monthNameWidget,
                  containerDecoration:
                      BoxDecoration(color: Colors.lightGreen[200]),
                  addSwipeGesture: true,
                )),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: _getDataTable(),
                    )),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
