import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdminHomePage();
}

class _AdminHomePage extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: Scaffold(
        appBar: AppBar(
          title: Text('픽업 관리'),
        ),
      ),
    );
  }
}