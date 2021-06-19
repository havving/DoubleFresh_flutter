/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScheduleTimeDialog extends StatefulWidget {
  int id, day;

  ScheduleTimeDialog(this.id, this.day);

  @override
  _ScheduleTimeState createState() => new _ScheduleTimeState(this.id, this.day);
}

class _ScheduleTimeState extends State<ScheduleTimeDialog> {
  final _scheduleTimeUrl = Uri.parse('http://192.168.0.22:3000/user/schedule_time ');

  final int id;
  final int day;

  TimeOfDay? _selectedTime;

  _ScheduleTimeState(this.id, this.day);

  @override
  Widget build(BuildContext context) {
      Future<TimeOfDay?> selectedTime = showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context,
      );
      selectedTime.then((time) async {
        setState(() {
          _selectedTime = time;
        });
        print('선택되었습니다');

        var data = {
          "id": id,
          "day": day,
          "time": _selectedTime,
        };
        var body = json.encode(data);
        http.Response _res = await http.post(_scheduleTimeUrl,
            headers: {
              "Content-Type": "application/json",
              "Access-Control-Allow-Origin": "*"
            },
            body: body);
      });
  }
}
*/
