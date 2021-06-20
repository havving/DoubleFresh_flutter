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
      title: Text('픽업 날짜 고정하기'),
      content: SingleChildScrollView(
        child: ToggleButtons(
          children: <Widget>[
            Text('월'),
            Text('화'),
            Text('수'),
            Text('목'),
            Text('금'),
          ],
          isSelected: _btnState,
          selectedColor: Colors.green,
          selectedBorderColor: Colors.green[300],
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
        FlatButton(
          child: Text('닫기'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('확인'),
          onPressed: () async {
            var data = {
              "id": id,
              "date": _selectDate
            };
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
