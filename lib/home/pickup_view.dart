import 'package:double_fresh/model/pickup_info.dart';
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

  Iterable<PickupInfo> list = List<PickupInfo>
      .from(subJson.pickupInfo).map((x) => PickupInfo.fromJson(x)););

  late List<PickupInfo> pickupInfo = subJson.pickupInfo.cast<PickupInfo>();

  @override
  Widget build(BuildContext context) {
    print(pickupInfo);
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
          // Text(pickupInfo[0].day.toString() + pickupInfo[0].time.toString() + pickupInfo[0].salad),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              // child: _getDataTable(),
            ),
          ),
        ],
      ),
    );
  }

  /// 표 데이터 값
  /*Widget _getDataTable() {
    return DataTable(
      horizontalMargin: 12.0,
      columnSpacing: 28.0,
      columns: _getColumns(),
      rows: _getRows(),
    );
  }

  void _dataColumnSort(int columnIndex, bool ascending) {
    print('_dataColumnSort() $columnIndex $ascending');
  }

  /// columns
  List<DataColumn> _getColumns() {
    List<DataColumn> dataColumn = [];
    for (var i in ) {
      dataColumn.add(DataColumn(label: Text(i), numeric: true, onSort: _dataColumnSort));
    }
  }

  List<DataRow> _getRows() {
    List<DataRow> dataRow = [];
    for (var i = 0; i < ; i++) {

    }
  }*/


}
