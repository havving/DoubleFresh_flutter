import 'package:flutter/material.dart';

class PickupDateDialog extends StatefulWidget {
  @override
  _PickupDateState createState() => new _PickupDateState();
}

class _PickupDateState extends State<PickupDateDialog> {
  List<bool> _btnState = List.generate(5, (index) => false);

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
          onPressed: () {
            // TODO 픽업날짜 고정
          },
        ),
      ],
    );
  }
}