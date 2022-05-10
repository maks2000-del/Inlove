import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:inlove/injector.dart';
import 'package:inlove/models/user_model.dart';
import 'package:inlove/pages/tabs/calendar/calendar_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helpers/shared_preferences.dart';
import '../../../models/entities/internet_connection.dart';
import '../../../models/special_date_model.dart';
import '../../../repository/sqlite_repository.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit()
      : super(
          CalendarState(
            specialDateConstructorTitle: 'One more..',
            toggleDate: 0,
            listOfDates: [],
          ),
        );
  final internetConnection = locator.get<InternetConnection>();

  final user = locator.get<User>();
  final sqliteDateRepository = locator.get<SqliteDateRepository>();

  void initState() async {
    internetConnection.status ? getCoupleDates() : getLocalCoupleDates();
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
        'bgColorId': state.toggleDate.toString(),
      }),
    );
    final speicalDate = SpeicalDate(
      id: null,
      coupleId: user.coupleId!,
      title: title,
      date: date,
      bgColorId: state.toggleDate,
    );
    addToLocalStorage(speicalDate);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  void addToLocalStorage(SpeicalDate speicalDate) {
    sqliteDateRepository.insert(speicalDate, user.coupleId!);
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
      debugPrint(e.toString());
    }
  }

  void getLocalCoupleDates() async {
    //TODO getIt
    final prefs = await SharedPreferences.getInstance();
    final sp = SharedPreferencesProvider(prefs);
    List<SpeicalDate> dates =
        await sqliteDateRepository.getEntityList(sp.getCoupleId());

    emit(
      state.copyWith(listOfDates: dates),
    );
  }

  void switchToggleDate(int selectedIndex) {
    emit(
      state.copyWith(toggleDate: selectedIndex),
    );
  }
}
