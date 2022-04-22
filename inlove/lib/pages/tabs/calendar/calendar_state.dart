import '../../../models/special_date_model.dart';

class CalendarState {
  final String calendarTabTitle;
  final String specialDateConstructorTitle;
  final List<SpeicalDate> listOfDates;

  CalendarState({
    required this.calendarTabTitle,
    required this.specialDateConstructorTitle,
    required this.listOfDates,
  });

  CalendarState copyWith({
    String? calendarTabTitle,
    String? specialDateConstructorTitle,
    List<SpeicalDate>? listOfDates,
  }) {
    return CalendarState(
      calendarTabTitle: calendarTabTitle ?? this.calendarTabTitle,
      specialDateConstructorTitle:
          specialDateConstructorTitle ?? this.specialDateConstructorTitle,
      listOfDates: listOfDates ?? this.listOfDates,
    );
  }
}
