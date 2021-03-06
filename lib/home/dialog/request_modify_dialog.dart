import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RequestModifyDialog extends StatefulWidget {
  int id;

  RequestModifyDialog(this.id);

  @override
  _RequestModifyState createState() => new _RequestModifyState(this.id);
}

class _RequestModifyState extends State<RequestModifyDialog> {
  final _requestController = TextEditingController();
  final _requestModifyUrl =
      Uri.parse('http://192.168.0.22:3000/request_modify');

  final int id;

  _RequestModifyState(this.id);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('요청사항 수정하기',
          style: TextStyle(
            fontFamily: 'NanumSquare',
            fontSize: 20.0,
          )),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              controller: _requestController,
              decoration: InputDecoration(
                labelText: '요청사항 입력',
                labelStyle: TextStyle(fontFamily: 'NanumSquare'),
                hintText: '요청사항 입력',
                hintStyle: TextStyle(fontFamily: 'NanumSquare'),
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
          child: Text('확인', style: TextStyle(fontFamily: 'NanumSquare')),
          color: Colors.teal[300],
          onPressed: () async {
            var data = {
              "id": id,
              "request": _requestController.text,
            };
            var body = json.encode(data);
            http.Response _res = await http.put(_requestModifyUrl,
                headers: {
                  "Content-Type": "application/json",
                  "Access-Control-Allow-Origin": "*"
                },
                body: body);
            requestModifyAlert(context, _res.body);
            // TODO 2개의 팝업창을 동시에 CLOSE 하는 방법?
          },
        ),
      ],
    );
  }

  /// 요청사항 수정 팝업
  void requestModifyAlert(BuildContext context, text) {
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
