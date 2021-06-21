import 'dart:convert';

import 'package:double_fresh/admin/admin_page.dart';
import 'package:double_fresh/home/calendar.dart';
import 'package:double_fresh/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _isChecked = false;
  final _url = Uri.parse('http://192.168.0.22:3000/user/login_user');

  final _idController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              SizedBox(height: 80.0),
              Column(
                children: <Widget>[
                  Image.asset('assets/images/sprout.png'),
                  SizedBox(height: 8.0),
                  Text('Double Fresh'),
                ],
              ),
              SizedBox(height: 120.0),
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'ID',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        },
                      ),
                      Text('ID 저장'),
                    ],
                  ),
                  ButtonBar(
                    children: <Widget>[
                      RaisedButton(
                        child: Text('로그인'),
                        onPressed: () async {
                          var data = {
                            "id": _idController.text,
                            "password": _passwordController.text,
                            "rememberId": _isChecked
                          };
                          var body = json.encode(data);
                          http.Response _res = await http.post(_url,
                              headers: {
                                "Content-Type": "application/json",
                                "Access-Control-Allow-Origin": "*"
                              },
                              body: body);
                          print(_res.body);
                          if (_res.body.toString()[0] == '{') {
                            Map<String, dynamic> jsonMap =
                                jsonDecode(_res.body);
                            var fromJson = User.fromJson(jsonMap);

                            // 관리자 page
                            if (fromJson.id == 9999) {
                              Navigator.push(
                                context,
                                CustomRoute(
                                    builder: (context) => AdminPage()),
                              );
                            } else {
                              // 사용자 page
                              Navigator.push(
                                context,
                                CustomRoute(
                                    builder: (context) => Calendar(fromJson)),
                              );
                            }
                          } else {
                            loginFailAlert(context, _res.body);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 로그인 실패 팝업
  void loginFailAlert(BuildContext context, text) {
    var alert = AlertDialog(
      title: Text('로그인 실패'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[Text(text)],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
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
