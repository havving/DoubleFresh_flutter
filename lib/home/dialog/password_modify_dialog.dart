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
  bool _obscureText = true;

  _PasswordModifyState(this.id);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('비밀번호 변경하기',
          style: TextStyle(
            fontFamily: 'NanumSquare',
            fontSize: 20.0,
          )),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              controller: _newPasswordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                hintText: '새 비밀번호',
                hintStyle: TextStyle(fontFamily: 'NanumSquare'),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    semanticLabel:
                        _obscureText ? 'show password' : 'hide password',
                    color: Colors.blue[900],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          child: Text('닫기', style: TextStyle(fontFamily: 'NanumSquare')),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        MaterialButton(
          child: Text('확인', style: TextStyle(fontFamily: 'NanumSquare')),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
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
        FlatButton(
          child: Text('OK', style: TextStyle(fontFamily: 'NanumSquare')),
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
