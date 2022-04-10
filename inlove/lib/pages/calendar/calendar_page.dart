import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  static const routeName = '/calendarPage';
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('calendar')),
    );
  }
}
