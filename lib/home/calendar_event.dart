import 'package:cell_calendar/cell_calendar.dart';
import 'package:flutter/material.dart';

List<CalendarEvent> sampleEvents() {
  final today = DateTime.utc(2021, 7, 1);
  final sampleEvents = [
    /*CalendarEvent(
        eventName: "아보카도 샐러드",
        eventDate: today),*/

    CalendarEvent(
        eventName: "베이컨 샐러드",
        eventDate: today.add(Duration(days: 4)),
        eventBackgroundColor: Colors.pinkAccent),
    CalendarEvent(
        eventName: "과일 샐러드",
        eventDate: today.add(Duration(days: 5)),
        eventBackgroundColor: Colors.orangeAccent),
    CalendarEvent(
        eventName: "훈제오리 샐러드",
        eventDate: today.add(Duration(days: 6)),
        eventBackgroundColor: Colors.brown),
    CalendarEvent(
        eventName: "단호박 샐러드",
        eventDate: today.add(Duration(days: 7)),
        eventBackgroundColor: Colors.amberAccent),
    CalendarEvent(
        eventName: "닭가슴살 샐러드",
        eventDate: today.add(Duration(days: 8)),
        eventBackgroundColor: Colors.blueGrey),
    CalendarEvent(
        eventName: "크래미 샐러드",
        eventDate: today.add(Duration(days: 11)),
        eventBackgroundColor: Colors.red),
    CalendarEvent(
        eventName: "부채살 샐러드",
        eventDate: today.add(Duration(days: 12)),
        eventBackgroundColor: Colors.cyan),
    CalendarEvent(
        eventName: "견과류 샐러드",
        eventDate: today.add(Duration(days: 13)),
        eventBackgroundColor: Colors.teal),
    CalendarEvent(
        eventName: "아보카도 샐러드",
        eventDate: today.add(Duration(days: 14)),
        eventBackgroundColor: Colors.green),
    CalendarEvent(
        eventName: "새송이버섯 샐러드",
        eventDate: today.add(Duration(days: 15)),
        eventBackgroundColor: Colors.lightGreen),
    CalendarEvent(
        eventName: "훈제오리 샐러드",
        eventDate: today.add(Duration(days: 18)),
        eventBackgroundColor: Colors.brown),
    CalendarEvent(
        eventName: "단호박 샐러드",
        eventDate: today.add(Duration(days: 19)),
        eventBackgroundColor: Colors.amberAccent),
    CalendarEvent(
        eventName: "가지새우 샐러드",
        eventDate: today.add(Duration(days: 20)),
        eventBackgroundColor: Colors.orange),
    CalendarEvent(
        eventName: "베이컨 샐러드",
        eventDate: today.add(Duration(days: 21)),
        eventBackgroundColor: Colors.pinkAccent),
    CalendarEvent(
        eventName: "과일 샐러드",
        eventDate: today.add(Duration(days: 22)),
        eventBackgroundColor: Colors.orangeAccent),
    CalendarEvent(
        eventName: "닭가슴살 샐러드",
        eventDate: today.add(Duration(days: 25)),
        eventBackgroundColor: Colors.blueGrey),
    CalendarEvent(
        eventName: "크래미 샐러드",
        eventDate: today.add(Duration(days: 26)),
        eventBackgroundColor: Colors.red),
    CalendarEvent(
        eventName: "부채살 샐러드",
        eventDate: today.add(Duration(days: 27)),
        eventBackgroundColor: Colors.cyan),
    CalendarEvent(
        eventName: "새송이버섯 샐러드",
        eventDate: today.add(Duration(days: 28)),
        eventBackgroundColor: Colors.lightGreen),
    CalendarEvent(
        eventName: "아보카도 샐러드",
        eventDate: today.add(Duration(days: 29)),
        eventBackgroundColor: Colors.green),
  ];
  return sampleEvents;
}
