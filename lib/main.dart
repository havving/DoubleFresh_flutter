import 'dart:convert';

import 'package:double_fresh/admin/admin_page.dart';
import 'package:double_fresh/home/calendar.dart';
import 'package:double_fresh/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(home: LoginPage()));
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _isChecked = false;
  final _url = Uri.parse('http://192.168.0.22:3000/user/login_user');

  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  String _id = '';
  String _pw = '';
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Center(
        child: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(20.0),
            child: Center(
              child: new Form(
                child: _getFormUI(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getFormUI() {
    return new Column(
      children: <Widget>[
        Image.asset('assets/images/logo.png'),
        SizedBox(height: 80.0),
        TextField(
          controller: _idController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'ID',
            filled: true,
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
            ),
          ),
        ),
        SizedBox(height: 20.0),
        TextField(
          controller: _passwordController,
          obscureText: _obscureText,
          decoration: InputDecoration(
            hintText: 'Password',
            filled: true,
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.teal),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                semanticLabel: _obscureText ? 'show password' : 'hide password',
                color: Colors.cyan[800],
              ),
            ),
          ),
        ),
        SizedBox(height: 15.0),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.cyan[800],
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                padding: EdgeInsets.all(12),
                fixedSize: Size(150, 50)),
            child: Text('로그인',
                style: TextStyle(fontFamily: 'NanumSquare', fontSize: 20)),
            onPressed: () async {
              _id = _idController.text;
              _pw = _passwordController.text;

              var data = {"id": _id, "password": _pw, "rememberId": _isChecked};
              var body = json.encode(data);
              http.Response _res = await http.post(_url,
                  headers: {
                    "Content-Type": "application/json",
                    "Access-Control-Allow-Origin": "*"
                  },
                  body: body);
              print(_res.body);
              if (_res.body.toString()[0] == '{') {
                Map<String, dynamic> jsonMap = jsonDecode(_res.body);
                var fromJson = User.fromJson(jsonMap);

                // 관리자 page
                if (fromJson.id == 9999) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminPage()),
                  );
                } else {
                  // 사용자 page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Calendar(fromJson)),
                  );
                }
              } else {
                loginFailAlert(context, _res.body);
              }
            },
          ),
        ),
      ],
    );
  }

  /// 로그인 실패 팝업
  void loginFailAlert(BuildContext context, text) {
    var alert = AlertDialog(
      title: Text(
        '로그인 실패',
        style: TextStyle(
          fontFamily: 'NanumSquare',
          fontSize: 20.0,
        ),
      ),
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
            Navigator.of(context).pop();
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
