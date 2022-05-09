import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:inlove/injector.dart';
import 'package:inlove/models/user_model.dart';
import 'package:inlove/pages/tabs/calendar/calendar_state.dart';

import '../../../models/special_date_model.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit()
      : super(
          CalendarState(
            calendarTabTitle: 'My dates',
            specialDateConstructorTitle: 'One more..',
            listOfDates: [],
          ),
        );
  final user = locator.get<User>();

  void initState() async {
    getCoupleDates();
    emit(
      state.copyWith(),
    );
  }

  Future<bool> createNewDate(String title, String date) async {
    final response = await post(
      Uri.parse('http://10.0.2.2:3001/api/date'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'coupleId': user.coupleId.toString(),
        'title': title,
        'actionDate': date,
        'bgColorId': "0",
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  void getCoupleDates() async {
    List<SpeicalDate> dates = [];
    try {
      Response response = await get(
          Uri.parse("http://10.0.2.2:3001/api/dates/${user.coupleId}"));
      if (response.statusCode == 200) {
        for (final date in jsonDecode(response.body)) {
          final speicalDate = SpeicalDate.fromJson(date);
          dates.add(speicalDate);
        }
      }
      emit(
        state.copyWith(listOfDates: dates),
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
