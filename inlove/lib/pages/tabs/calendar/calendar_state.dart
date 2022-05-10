import '../../../models/special_date_model.dart';

class CalendarState {
  final String specialDateConstructorTitle;
  final int toggleDate;
  final List<SpeicalDate> listOfDates;

  CalendarState({
    required this.specialDateConstructorTitle,
    required this.toggleDate,
    required this.listOfDates,
  });

  CalendarState copyWith({
    String? specialDateConstructorTitle,
    int? toggleDate,
    List<SpeicalDate>? listOfDates,
  }) {
    return CalendarState(
      specialDateConstructorTitle:
          specialDateConstructorTitle ?? this.specialDateConstructorTitle,
      toggleDate: toggleDate ?? this.toggleDate,
      listOfDates: listOfDates ?? this.listOfDates,
    );
  }
}
