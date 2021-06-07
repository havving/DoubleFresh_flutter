import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'user/login.dart';

void main() {
  runApp(LoginPage());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'http 서버 데이터 전송'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text = '변경되기 전!';
  var _url = Uri.parse('http://192.168.0.22:3000/');
  var _url2 = Uri.parse('http://192.168.0.22:3000/data');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('버튼을 누르면 하단 글귀가 변경됩니다.', style: TextStyle(color: Colors.indigo, fontSize: 20.0, fontWeight: FontWeight.bold),),
            Text( '$_text', style: TextStyle(color: Colors.green, fontSize: 36.0, fontWeight: FontWeight.bold) ),
          ],
        ),
      ),

      floatingActionButton: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                onPressed: () async {
                  http.Response _res = await http.get(_url);
                  print(_res.statusCode);
                  print(_res.body);
                  setState(() {
                    _text = _res.body;
                  });
                },
                child: Icon(Icons.chevron_left),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  margin: const EdgeInsets.only(left: 180.0),
                  child: Text("Get  Post", style: TextStyle(color: Colors.blueAccent, fontSize: 28.0, fontWeight: FontWeight.bold),)
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child:  FloatingActionButton(
                onPressed: () async {
                  var data = {
                    "id" : "1",
                    "name" : "Jin",
                    "age" : "20"
                  };
                  var body = json.encode(data);
                  http.Response _res = await http.post(_url2, headers: {"Content-Type": "application/json",
                    "Access-Control-Allow-Origin": "*"}, body: body);
                  print(_res.statusCode);
                  print(_res.body);
                  setState(() {
                    _text = _res.body;
                  });
                },
                child: Icon(Icons.chevron_right),
              ),
            )
          ]
      ),
    );
  }
}