import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'admin_home_page.dart';
import 'admin_user_page.dart';

class AdminPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdminPage();
}

class _AdminPage extends State<StatefulWidget> {
  int _curIndex = 0;
  List jsonList = [];

  var jsonMap;

  final _adminUserInfoUrl = Uri.parse('http://192.168.0.22:3000/admin/user_info');
  final _adminPickupUrl = 'http://192.168.0.22:3000/admin/pickup/';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: Scaffold(
        body: getPage(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) async {
            if (index == 1) {
              http.Response _res = await http.get(_adminUserInfoUrl);
              jsonMap = jsonDecode(_res.body);
            } else {
              var url = _adminPickupUrl + DateTime.now().day.toString();
              http.Response _res = await http.get(Uri.parse(url));
              jsonMap = jsonDecode(_res.body);
            }
            setState(() {
              jsonList = jsonMap;
              _curIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
                color: _curIndex == 0 ? Colors.blue : Colors.black54,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  fontSize: 15,
                  color: _curIndex == 0 ? Colors.blue : Colors.black54,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 30,
                color: _curIndex == 1 ? Colors.blue : Colors.black54,
              ),
              title: Text(
                'User',
                style: TextStyle(
                  fontSize: 15,
                  color: _curIndex == 1 ? Colors.blue : Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getPage() {
    late Widget page;
    switch (_curIndex) {
      case 0:
        page = AdminHomePage(jsonList);
        break;
      case 1:
        page = AdminUserPage(jsonList);
        break;
    }
    return page;
  }
}
