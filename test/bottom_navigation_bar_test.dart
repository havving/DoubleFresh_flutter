import 'package:flutter/material.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _curIndex = 0;
  List<Widget> screenList = [Text('홈 스크린'), Text('채팅 스크린'), Text('마이 스크린')];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: screenList[_curIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _curIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: _curIndex == 0 ? Colors.green : Colors.black54),
            title: Text(
              'Home',
              style: TextStyle(
                color: _curIndex == 0 ? Colors.green : Colors.black54,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat,
                color: _curIndex == 1 ? Colors.green : Colors.black54),
            title: Text(
              'Chat',
              style: TextStyle(
                color: _curIndex == 1 ? Colors.green : Colors.black54,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people,
                color: _curIndex == 2 ? Colors.green : Colors.black54),
            title: Text(
              'My',
              style: TextStyle(
                color: _curIndex == 2 ? Colors.green : Colors.black54,
              ),
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            //상태 갱신이 되지 않으면 동작을 하지 않음
            _curIndex = index;
          });
        },
      ),
    );
  }
}