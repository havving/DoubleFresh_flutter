import 'package:flutter/material.dart';

void main() => runApp(MyMenu());

class MyMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppBar',
      theme: ThemeData(primarySwatch: Colors.red),
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AppBar"),
        centerTitle: true,
        elevation: 0.0,
        leading:
            IconButton(icon: Icon(Icons.menu), onPressed: () => {print("hi")}),
        actions: [
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () => {print("hi22")}),
          IconButton(
              icon: Icon(Icons.search), onPressed: () => {print("hi33")}),
        ],
      ),
    );
  }
}
