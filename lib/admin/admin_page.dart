import 'package:flutter/material.dart';

import 'admin_home_page.dart';
import 'admin_user_page.dart';

class AdminPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AdminPage();
}

class _AdminPage extends State<StatefulWidget> {
  int _curIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: Scaffold(
        body: getPage(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
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
        page = AdminHomePage();
        break;
      case 1:
        page = AdminUserPage();
        break;
    }
    return page;
  }
}
