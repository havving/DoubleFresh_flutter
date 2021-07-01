import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminUserAddDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdminUserAddState();
}

class _AdminUserAddState extends State<StatefulWidget> {
  var _statusDropdownValue;
  var _countDropdownValue;

  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _requestController = TextEditingController();

  final _userSignupUrl = Uri.parse('http://192.168.0.22:3000/user/signup');

  @override
  void initState() {
    super.initState();
    _statusDropdownValue = 'Y';
    _countDropdownValue = '2';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('ID'),
            TextField(
              controller: _idController,
            ),
            Text('이름'),
            TextField(
              controller: _nameController,
            ),
            Text('휴대폰번호'),
            TextField(
              controller: _phoneController,
            ),
            Text('구독여부'),
            DropdownButton(
                value: _statusDropdownValue,
                items: ['Y', 'N']
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    _statusDropdownValue = newValue;
                  });
                },
            ),
            Text('구독횟수'),
            DropdownButton(
              value: _countDropdownValue,
              items: ['2', '3', '5']
                  .map((value) => DropdownMenuItem(
                value: value,
                child: Text(value),
              ))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  _countDropdownValue = newValue;
                });
              },
            ),
            Text('요청사항'),
            TextField(
              controller: _requestController,
            ),
          ],
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
          child: Text('추가'),
          onPressed: () async {
            var data = {
              "id": _idController.text,
              "name": _nameController.text,
              "phone": _phoneController.text,
              "status": _statusDropdownValue,
              "count": _countDropdownValue,
              "request": _requestController.text,
            };
            var body = json.encode(data);
            http.Response _res = await http.post(_userSignupUrl,
                headers: {
                  "Content-Type": "application/json",
                  "Access-Control-Allow-Origin": "*"
                },
                body: body);
            userAddAlert(context, _res.body);
            // TODO 2개의 팝업창을 동시에 CLOSE 하는 방법?
          },
        ),
      ],
    );
  }

  /// 팝업
  void userAddAlert(BuildContext context, text) {
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
