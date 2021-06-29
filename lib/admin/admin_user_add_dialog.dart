import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminUserAddDialog extends StatefulWidget {

  @override
  State<StatefulWidget> createState() =>
      _AdminUserAddState();
}

class _AdminUserAddState extends State<StatefulWidget> {

  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _requestController = TextEditingController();

  final _userSignupUrl = Uri.parse('http://192.168.0.22:3000/user/signup');

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
            // TODO 추가할 것: 구독여부, 구독횟수(월), 요청사항도 입력해서 Sub/Detail 테이블에 모두 넣기
            // TODO 총 픽업횟수는 구독횟수에 따라 switch-case문으로 보내기
            Text('구독여부'),
            Text('구독횟수'),
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
              "status": _phoneController.text,

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