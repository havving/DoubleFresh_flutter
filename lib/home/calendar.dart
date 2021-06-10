import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';

import 'calendar_event.dart';

class Calendar extends StatefulWidget {
  // Calendar({Key? key, required this.title}) : super(key: key);
  // final String title;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Double_Fresh',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: '이달의 샐러드'),
    );
  }

  @override
  State<StatefulWidget> createState() => _MyHomePage();
}

class _MyHomePage extends State<StatefulWidget> {
  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    final _sampleEvents = sampleEvents();
    final cellCalendarPageController = CellCalendarPageController();
    return Scaffold(
      appBar: AppBar(
        title: Text('이달의 샐러드'),
/*        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => {},
          )
        ],*/
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("황혜빈 님"),
              accountEmail: Text("6월 정기구독 중"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/images/sprout.png'),
              ),
              // 빨간 부분을 꾸미기 위한 기능
              decoration: BoxDecoration(
                  color: Colors.red[200],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0))),
            ),
            ListTile(
              leading: Icon(
                Icons.face,
                color: Colors.grey[850],
              ),
              title: Text('내 정보'),
              onTap: () => {
                ListTile(title: Text('비밀번호 변경하기')),
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.grey[850],
              ),
              title: Text('Setting'),
              onTap: () => {print("Setting!!")},
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(
                Icons.local_phone,
                color: Colors.grey[850],
              ),
              title: Text('032-xxx-xxxx'),
            ),
          ],
        ),
      ),
      body: CellCalendar(
        cellCalendarPageController: cellCalendarPageController,
        events: _sampleEvents,
        daysOfTheWeekBuilder: (dayIndex) {
          final labels = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"];
          return Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              labels[dayIndex],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          );
        },
        monthYearLabelBuilder: (datetime) {
          final year = datetime!.year.toString();
          final month = datetime.month.monthName;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Text(
                  "$year  $month월",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
/*                IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {
                    cellCalendarPageController.animateToDate(
                      DateTime.now(),
                      curve: Curves.linear,
                      duration: Duration(milliseconds: 300),
                    );
                  },
                )*/
              ],
            ),
          );
        },
        onCellTapped: (date) {
          final eventsOnTheDate = _sampleEvents.where((event) {
            final eventDate = event.eventDate;
            return eventDate.year == date.year &&
                eventDate.month == date.month &&
                eventDate.day == date.day;
          }).toList();
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text(date.month.monthName +
                        '월 ' +
                        date.day.toString() +
                        '일'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: eventsOnTheDate
                          .map(
                            (event) => Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(4),
                              margin: EdgeInsets.only(bottom: 12),
                              color: event.eventBackgroundColor,
                              child: Text(
                                event.eventName,
                                style: TextStyle(color: event.eventTextColor),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('예약하기'),
                        onPressed: () {
                          Future<TimeOfDay?> selectedTime = showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );
                          selectedTime.then((date) {
                            setState(() {
                              _selectedTime = date;
                            });
                          });
                        },
                      ),
                      if (_selectedTime != null)
                        Text('${_selectedTime!.hour}:${_selectedTime!.minute}'),
                    ],
                  ));
        },
        onPageChanged: (firstDate, lastDate) {
          /// Called when the page was changed
          /// Fetch additional events by using the range between [firstDate] and [lastDate] if you want
        },
      ),
    );
  }
}
