import 'dart:convert';

import 'package:cell_calendar/cell_calendar.dart';
import 'package:double_fresh/home/pickup_null.dart';
import 'package:double_fresh/home/pickup_view.dart';
import 'package:double_fresh/model/subscription.dart';
import 'package:double_fresh/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'calendar_event.dart';
import 'dialog/password_modify_dialog.dart';
import 'dialog/pickup_date_dialog.dart';
import 'dialog/request_modify_dialog.dart';

class Calendar extends StatefulWidget {
  User fromJson;

  Calendar(this.fromJson);

  @override
  State<StatefulWidget> createState() => _MyHomePage(fromJson: fromJson);
}

class _MyHomePage extends State<StatefulWidget> {
  late User fromJson;

  _MyHomePage({required this.fromJson});

  late String _selectedTime;

  final _pickupTimeUrl = Uri.parse('http://192.168.0.22:3000/pickup_time');
  final _fixedPickupTimeUrl =
      Uri.parse('http://192.168.0.22:3000/fixed_pickup_time');

  late String saladName;

  @override
  Widget build(BuildContext context) {
    final _sampleEvents = sampleEvents();
    final cellCalendarPageController = CellCalendarPageController();

    final _subscriptionUrl =
        Uri.parse('http://192.168.0.22:3000/subscription/');

    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.lightGreen, fontFamily: 'NanumSquare'),
      home: Scaffold(
        appBar: AppBar(
          title: Text('이달의 샐러드'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text('안녕하세요, ' + fromJson.name + '님!',
                    style: TextStyle(fontSize: 18)),
                accountEmail: Text("7월 정기구독 중입니다."),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/logo_icon.png'),
                ),
                // 배경색
                decoration: BoxDecoration(
                    color: Colors.lightGreen[400],
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
                      Icons.book_outlined,
                      color: Colors.grey[850],
                    ),
                    title: Text('픽업 현황 보기'),
                    onTap: () async {
                      var data = {
                        "id": fromJson.id,
                      };
                      var body = json.encode(data);
                      http.Response _res = await http.post(_subscriptionUrl,
                          headers: {
                            "Content-Type": "application/json",
                            "Access-Control-Allow-Origin": "*"
                          },
                          body: body);
                      if (_res.body.toString()[0] == '{') {
                        Map<String, dynamic> jsonMap = jsonDecode(_res.body);
                        var subJson = Subscription.fromJson(jsonMap);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PickupViewPage(subJson)),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PickupNullPage()),
                        );
                      }
                    },
                  ),
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
                          return PickupDateDialog(fromJson.id);
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
                      selectedTime.then((time) async {
                        setState(() {
                          _selectedTime = '${time!.hour}:${time.minute}';
                        });
                        print(_selectedTime);

                        var data = {
                          "id": fromJson.id,
                          "time": _selectedTime,
                        };
                        var body = json.encode(data);
                        http.Response _res = await http.put(_fixedPickupTimeUrl,
                            headers: {
                              "Content-Type": "application/json",
                              "Access-Control-Allow-Origin": "*"
                            },
                            body: body);
                        pickupTimeAlert(context, _res.body);
                        // TODO 2개의 팝업창을 동시에 CLOSE 하는 방법?
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
                        builder: (_) {
                          return RequestModifyDialog(fromJson.id);
                        }),
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
                      title: Text(
                          date.month.monthName +
                              '월 ' +
                              date.day.toString() +
                              '일',
                          style: TextStyle(fontFamily: 'NanumSquare')),
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
                                  saladName = event.eventName,
                                  style: TextStyle(
                                      color: event.eventTextColor,
                                      fontFamily: 'NanumSquare'),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      actions: <Widget>[
                        MaterialButton(
                          child: Text('닫기',
                              style: TextStyle(fontFamily: 'NanumSquare')),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        // 오늘 이후의 날짜만 '예약하기' 가능
                        if (DateTime.now().day <= date.day)
                          MaterialButton(
                            child: Text('예약하기',
                                style: TextStyle(fontFamily: 'NanumSquare')),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Colors.white,
                            onPressed: () {
                              Future<TimeOfDay?> selectedTime = showTimePicker(
                                initialTime: TimeOfDay.now(),
                                context: context,
                              );
                              selectedTime.then((time) async {
                                setState(() {
                                  _selectedTime =
                                      '${time!.hour}:${time.minute}';
                                });
                                print(_selectedTime);

                                var data = {
                                  "id": fromJson.id,
                                  "day": date.day,
                                  "time": _selectedTime,
                                  "salad": saladName,
                                };
                                var body = json.encode(data);
                                http.Response _res = await http.put(
                                    _pickupTimeUrl,
                                    headers: {
                                      "Content-Type": "application/json",
                                      "Access-Control-Allow-Origin": "*"
                                    },
                                    body: body);
                                pickupTimeAlert(context, _res.body);
                                // TODO 2개의 팝업창을 동시에 CLOSE 하는 방법?
                              });
                            },
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

  /// 픽업 시간 팝업
  void pickupTimeAlert(BuildContext context, text) {
    var alert = AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[Text(text)],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(/*result*/);
          },
        ),
      ],
    );

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return alert;
        });
  }
}
