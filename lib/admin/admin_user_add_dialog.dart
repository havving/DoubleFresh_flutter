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
      title: Text('구독자 추가', style: TextStyle(fontFamily: 'NanumSquare')),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'ID',
                labelStyle: TextStyle(fontFamily: 'NanumSquare'),
                hintText: 'ex) 0000',
                hintStyle: TextStyle(fontFamily: 'NanumSquare'),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15.0),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: '이름',
                labelStyle: TextStyle(fontFamily: 'NanumSquare'),
                hintText: 'ex) 김더블',
                hintStyle: TextStyle(fontFamily: 'NanumSquare'),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15.0),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '휴대폰 번호',
                labelStyle: TextStyle(fontFamily: 'NanumSquare'),
                hintText: '010을 제외한 8자리',
                hintStyle: TextStyle(fontFamily: 'NanumSquare'),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15.0),
            Text('구독 여부',
                style: TextStyle(fontFamily: 'NanumSquare', fontSize: 14)),
            DropdownButton(
              value: _statusDropdownValue,
              items: ['Y', 'N']
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontFamily: 'NanumSquare'),
                        ),
                      ))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  _statusDropdownValue = newValue;
                });
              },
            ),
            SizedBox(height: 15.0),
            Text('구독 횟수',
                style: TextStyle(fontFamily: 'NanumSquare', fontSize: 14)),
            DropdownButton(
              value: _countDropdownValue,
              items: ['2', '3', '5']
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontFamily: 'NanumSquare'),
                        ),
                      ))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  _countDropdownValue = newValue;
                });
              },
            ),
            SizedBox(height: 15.0),
            TextField(
              controller: _requestController,
              decoration: InputDecoration(
                labelText: '요청사항',
                labelStyle: TextStyle(fontFamily: 'NanumSquare'),
                border: OutlineInputBorder(),
              ),
            ),
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
        MaterialButton(
          child: Text('추가', style: TextStyle(fontFamily: 'NanumSquare')),
          color: Colors.teal[300],
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
