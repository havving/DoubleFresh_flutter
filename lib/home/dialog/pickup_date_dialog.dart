import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PickupDateDialog extends StatefulWidget {
  int id;

  PickupDateDialog(this.id);

  @override
  _PickupDateState createState() => new _PickupDateState(this.id);
}

class _PickupDateState extends State<PickupDateDialog> {
  final _fixedPickupDateUrl =
      Uri.parse('http://192.168.0.22:3000/fixed_pickup_date');
  final int id;

  _PickupDateState(this.id);

  List<bool> _btnState = List.generate(5, (index) => false);
  List<String> _selectDate = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('픽업 날짜 고정하기',
          style: TextStyle(
            fontFamily: 'NanumSquare',
            fontSize: 20.0,
          )),
      content: SingleChildScrollView(
        child: ToggleButtons(
          children: <Widget>[
            Text('월', style: TextStyle(fontFamily: 'NanumSquare')),
            Text('화', style: TextStyle(fontFamily: 'NanumSquare')),
            Text('수', style: TextStyle(fontFamily: 'NanumSquare')),
            Text('목', style: TextStyle(fontFamily: 'NanumSquare')),
            Text('금', style: TextStyle(fontFamily: 'NanumSquare')),
          ],
          isSelected: _btnState,
          selectedColor: Colors.teal[600],
          selectedBorderColor: Colors.teal[300],
          splashColor: Colors.teal,
          borderWidth: 5,
          onPressed: (int index) => {
            setState(() {
              _btnState[index] = !_btnState[index];
              switch (index) {
                case 0:
                  _selectDate.add('월');
                  break;
                case 1:
                  _selectDate.add('화');
                  break;
                case 2:
                  _selectDate.add('수');
                  break;
                case 3:
                  _selectDate.add('목');
                  break;
                case 4:
                  _selectDate.add('금');
                  break;
              }
            }),
          },
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
        MaterialButton(
          child: Text('확인', style: TextStyle(fontFamily: 'NanumSquare')),
          color: Colors.teal[300],
          onPressed: () async {
            var data = {"id": id, "date": _selectDate};
            var body = json.encode(data);
            http.Response _res = await http.put(_fixedPickupDateUrl,
                headers: {
                  "Content-Type": "application/json",
                  "Access-Control-Allow-Origin": "*"
                },
                body: body);
            fixedPickupDateAlert(context, _res.body);
            // TODO 2개의 팝업창을 동시에 CLOSE 하는 방법?
          },
        ),
      ],
    );
  }

  void fixedPickupDateAlert(BuildContext context, text) {
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
        MaterialButton(
          child: Text('확인', style: TextStyle(fontFamily: 'NanumSquare')),
          color: Colors.teal[300],
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
