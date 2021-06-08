import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';

List<CalendarEvent> sampleEvents() {
  final today = DateTime.now();
  final sampleEvents = [
    CalendarEvent(eventName: "아보카도 샐러드", eventDate: today),
    CalendarEvent(
        eventName: "가지새우 샐러드",
        eventDate: today.add(Duration(days: 3)),
        eventBackgroundColor: Colors.green),
    CalendarEvent(
        eventName: "부채살 샐러드",
        eventDate: today.add(Duration(days: 7)),
        eventBackgroundColor: Colors.pink),
  ];
  return sampleEvents;
}