import 'package:flutter/material.dart';

class TimePickerPage extends StatefulWidget {
  @override
  _TimePickerPageState createState() => _TimePickerPageState();
}

class _TimePickerPageState extends State<TimePickerPage> {
  String? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TimePicker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //RaisedButton, Text
            RaisedButton(
              onPressed: () {
                Future<TimeOfDay?> selectedTime = showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );

                selectedTime.then((timeOfDay) {
                  setState(() {
                    _selectedTime = '${timeOfDay!.hour}:${timeOfDay.minute}';
                  });
                });
              },
              child: Text('Show TimePicker'),
            ),
            Text('$_selectedTime', style: TextStyle(fontSize: 30),),
          ],
        ),
      ),
    );
  }
}
