import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PickupView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PickupView();
}

class _PickupView extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: Scaffold(
        appBar: AppBar(
          title: Text('내 픽업 현황'),
        ),
        body: Center(
            child: Text(''),
        ),
      ),
    );
  }
}
