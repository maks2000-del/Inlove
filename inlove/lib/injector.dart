import 'package:get_it/get_it.dart';
import 'package:inlove/pages/authentication/authentication_cubit.dart';
import 'package:inlove/pages/home/home_cubit.dart';
import 'package:inlove/pages/tabs/calendar/calendar_cubir.dart';
import 'package:inlove/pages/tabs/diary/diary_cubit.dart';
import 'package:inlove/pages/tabs/settings/settings_cubit.dart';

import 'repository/user_repository.dart';

final locator = GetIt.instance;

void setUp() {
  _setUpUserPerositories();
  _setUpCubits();
}

void _setUpUserPerositories() {
  locator.registerFactory<UserPerository>(
    () => UserPerository(),
  );
}

// void _setUpUseCases() {
//   locator.registerFactory<MainUseCase>(
//     () => MainUseCase(
//       locator.get<WeatherRepository>(),
//     ),
//   );
//   locator.registerFactory<TodayUseCase>(
//     () => TodayUseCase(
//       locator.get<WeatherRepository>(),
//     ),
//   );
//   locator.registerFactory<ForecastUseCase>(
//     () => ForecastUseCase(
//       locator.get<WeatherRepository>(),
//     ),
//   );
// }

void _setUpCubits() {
  locator.registerFactory<AuthorizationCubit>(
    () => AuthorizationCubit(),
  );
  locator.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
  locator.registerFactory<DiaryCubit>(
    () => DiaryCubit(),
  );
  locator.registerFactory<SettingsCubit>(
    () => SettingsCubit(),
  );
  locator.registerFactory<CalendarCubit>(
    () => CalendarCubit(),
  );
}
