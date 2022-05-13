import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inlove/injector.dart';
import 'package:inlove/models/user_model.dart';
import 'package:inlove/pages/tabs/calendar/calendar_state.dart';
import 'package:inlove/repository/special_date_repository.dart';

import '../../../helpers/shared_preferences.dart';
import '../../../models/entities/internet_connection.dart';
import '../../../models/special_date_model.dart';
import '../../../repository/entity_repository.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit()
      : super(
          CalendarState(
            specialDateConstructorTitle: 'One more..',
            toggleDate: 0,
            listOfDates: [],
          ),
        );

  final _user = locator.get<User>();
  final _internetConnection = locator.get<InternetConnection>();
  final _specialDateRepository = locator.get<SpecialDateRepository>();
  final _sqliteDateRepository = locator.get<SqliteDateRepository>();
  final _sharedPreferencesProvider = locator.get<SharedPreferencesProvider>();

  void initState() async {
    if (_user.coupleId != null) {
      _internetConnection.status ? getCoupleDates() : getLocalCoupleDates();
    }
    emit(
      state.copyWith(),
    );
  }

  Future<bool> createNewDate(String title, String date) async {
    final speicalDate = SpeicalDate(
      coupleId: _user.coupleId!,
      title: title,
      date: date,
      bgColorId: state.toggleDate,
    );
    final posted = await _specialDateRepository.postDate(speicalDate);
    _sqliteDateRepository.insert(speicalDate, _user.coupleId!);
    return posted;
  }

  void getCoupleDates() async {
    final dates = await _specialDateRepository.getCoupleDates(_user.coupleId!);

    emit(
      state.copyWith(listOfDates: dates),
    );
  }

  void getLocalCoupleDates() async {
    final coupleId = _sharedPreferencesProvider.getCoupleId();
    List<SpeicalDate> dates =
        await _sqliteDateRepository.getEntityList(coupleId);

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
