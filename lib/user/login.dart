import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = false;
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
              ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    child: Text('로그인'),
                    onPressed: () async {
                      var data = {
                        "id" : _idController.text,
                        "password" : _passwordController.text,
                      };
                      var body = json.encode(data);
                      http.Response _res = await http.post(_url,
                          headers: {"Content-Type": "application/json",
                            "Access-Control-Allow-Origin": "*"}, body: body);
                      print(_res.body);
                      if (_res.body.toString() == 'true') {
                        print('true');
                      } else {
                        print('false');
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
