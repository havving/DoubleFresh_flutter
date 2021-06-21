import 'package:flutter/material.dart';

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
        appBar: AppBar(
          title: Text('6월의 샐러드'),
        ),
        // body: getPage(),
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

/*Widget getPage() {
    Widget page;
    switch (_curIndex) {
      case 0:
        // page = page1();
        break;
      case 1:
        // page = page2();
        break;
    }
    return page;
  }*/

}
