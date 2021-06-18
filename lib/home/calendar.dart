import 'package:cell_calendar/cell_calendar.dart';
import 'package:double_fresh/model/user.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


import 'calendar_event.dart';
import 'dialog/PasswordModifyDialog.dart';
import 'dialog/pickupDateDialog.dart';

class Calendar extends StatefulWidget {
  User fromJson;

  Calendar(this.fromJson);

  // Calendar({Key? key, required this.title}) : super(key: key);
  // final String title;

  // This widget is the root of your application.
/*  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Double_Fresh',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: '이달의 샐러드'),
    );
  }*/

  @override
  State<StatefulWidget> createState() => _MyHomePage(fromJson: fromJson);
}

class _MyHomePage extends State<StatefulWidget> {
  late User fromJson;

  _MyHomePage({required this.fromJson});

  TimeOfDay? _selectedTime;

  @override
  Widget build(BuildContext context) {
    final _sampleEvents = sampleEvents();
    final cellCalendarPageController = CellCalendarPageController();
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.lightGreen),
      home: Scaffold(
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
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('안녕하세요, ' + fromJson.name + '님!'),
                accountEmail: Text("6월 정기구독 중"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/sprout.png'),
                ),
                // 배경색
                decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0))),
              ),
              ExpansionTile(
                leading: Icon(
                  Icons.face,
                  color: Colors.grey[850],
                ),
                title: Text(
                  '내 정보',
                ),
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.lock_outline,
                      color: Colors.grey[850],
                    ),
                    title: Text('비밀번호 변경하기'),
                    onTap: () => showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) {
                          return PasswordModifyDialog(fromJson.id);
                        }),
                  ),
                ],
              ),
              ExpansionTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.grey[850],
                ),
                title: Text('설정'),
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.calendar_today,
                      color: Colors.grey[850],
                    ),
                    title: Text('픽업 날짜 고정하기'),
                    onTap: () => showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) {
                          return PickupDateDialog();
                        }),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.access_time,
                      color: Colors.grey[850],
                    ),
                    title: Text('픽업 시간 고정하기'),
                    onTap: () {
                      Future<TimeOfDay?> selectedTime = showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );
                      selectedTime.then((time) {
                        setState(() {
                          _selectedTime = time;
                        });
                        print('선택되었습니다');
                      });
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.speaker_notes_outlined,
                      color: Colors.grey[850],
                    ),
                    title: Text('요청사항 수정하기'),
                    onTap: () => showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('요청사항 수정하기'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              TextField(
                                decoration:
                                    InputDecoration(labelText: '요청사항 입력'),
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('닫기'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text('확인'),
                            onPressed: () {
                              // TODO 요청사항 확인
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ListTile(
                leading: Icon(
                  Icons.local_phone,
                  color: Colors.grey[850],
                ),
                title: Text('Tel'),
                onTap: () => launch('tel://0324289233'),
              ),
              ListTile(
                leading: Icon(
                  Icons.launch,
                  color: Colors.grey[850],
                ),
                title: Text('Instagram'),
                onTap: () =>
                    launch('https://www.instagram.com/doublefresh_official/'),
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
                barrierDismissible: false,
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
                          child: Text('닫기'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        // 오늘 이후의 날짜만 '예약하기' 가능
                        if (DateTime.now().day <= date.day)
                          FlatButton(
                            child: Text('예약하기'),
                            onPressed: () {
                              Future<TimeOfDay?> selectedTime = showTimePicker(
                                initialTime: TimeOfDay.now(),
                                context: context,
                              );
                              selectedTime.then((time) {
                                setState(() {
                                  _selectedTime = time;
                                });
                                print('선택되었습니다');
                              });
                            },
                          ),
                        if (_selectedTime != null)
                          Text(
                            '${_selectedTime!.hour}:${_selectedTime!.minute}',
                            style: TextStyle(fontSize: 30),
                          ),
                      ],
                    ));
          },
          onPageChanged: (firstDate, lastDate) {
            /// Called when the page was changed
            /// Fetch additional events by using the range between [firstDate] and [lastDate] if you want
          },
        ),
      ),
    );
  }
}
