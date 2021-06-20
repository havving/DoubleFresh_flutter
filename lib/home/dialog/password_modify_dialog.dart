import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PasswordModifyDialog extends StatefulWidget {
  int id;
  PasswordModifyDialog(this.id);

  @override
  _PasswordModifyState createState() => new _PasswordModifyState(this.id);
}

class _PasswordModifyState extends State<PasswordModifyDialog> {

  final _newPasswordController = TextEditingController();
  final _pwModifyUrl = Uri.parse('http://192.168.0.22:3000/user/pw_modify');
  final int id;

  _PasswordModifyState(this.id);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('비밀번호 변경하기'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              controller: _newPasswordController,
              decoration:
              InputDecoration(
                  labelText: '새 비밀번호'
              ),
              obscureText: true,
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
          child: Text('확인'),
          onPressed: () async {
            var data = {
              "id": id,
              "newPassword": _newPasswordController.text,
            };
            var body = json.encode(data);
            http.Response _res = await http.put(_pwModifyUrl,
                headers: {
                  "Content-Type": "application/json",
                  "Access-Control-Allow-Origin": "*"
                },
                body: body);
            pwModifyAlert(context, _res.body);
            // TODO 2개의 팝업창을 동시에 CLOSE 하는 방법?
          },
        ),
      ],
    );
  }

  /// 비밀번호 변경 팝업
  void pwModifyAlert(BuildContext context, text) {
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