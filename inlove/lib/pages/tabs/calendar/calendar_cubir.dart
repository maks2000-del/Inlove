import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inlove/pages/tabs/calendar/calendar_state.dart';

import '../../../models/special_date_model.dart';

final List<SpeicalDate> _specialDates = [
  SpeicalDate(
    id: 0,
    coupleId: 0,
    title: 'test title',
    description: 'test description',
    date: DateTime.now(),
    bgColorId: 0,
  ),
  SpeicalDate(
    id: 0,
    coupleId: 0,
    title: 'test title',
    description: 'test description',
    date: DateTime.now(),
    bgColorId: 0,
  ),
  SpeicalDate(
    id: 0,
    coupleId: 0,
    title: 'test title',
    description: 'test description',
    date: DateTime.now(),
    bgColorId: 0,
  ),
];

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit()
      : super(
          CalendarState(
            calendarTabTitle: 'My dates',
            specialDateConstructorTitle: 'One more..',
            listOfDates: [],
          ),
        );

  void initState() async {
    emit(
      state.copyWith(listOfDates: _specialDates),
    );
  }

  void createNewDate() {}
}
