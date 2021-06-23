import 'package:flutter/material.dart';

class PickupNullPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("내 픽업 현황"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Text('구독 정보가 없습니다.'),
      ),
    );
  }

}