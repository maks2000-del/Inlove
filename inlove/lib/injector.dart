import 'package:get_it/get_it.dart';
import 'package:inlove/pages/authentication/authentication_cubit.dart';
import 'package:inlove/pages/home/home_cubit.dart';
import 'package:inlove/pages/tabs/calendar/calendar_cubir.dart';
import 'package:inlove/pages/tabs/diary/diary_cubit.dart';
import 'package:inlove/pages/tabs/settings/settings_cubit.dart';
import 'package:inlove/helpers/sqlite_helper.dart';
import 'package:inlove/repository/compliment_repository.dart';
import 'package:inlove/repository/couple_repository.dart';
import 'package:inlove/repository/entity_repository.dart';
import 'package:inlove/repository/memory_repository.dart';
import 'package:inlove/repository/special_date_repository.dart';
import 'package:sqflite/sqflite.dart';

import 'models/entities/internet_connection.dart';
import 'repository/user_repository.dart';

final locator = GetIt.instance;

void setUp() {
  _setUpConnection();
  _setUpSQLite();
  _setUpHttpRerositories();
  _setUpCubits();
}

void _setUpConnection() {
  locator.registerSingleton<InternetConnection>(
    InternetConnection(),
  );
}

void _setUpHttpRerositories() {
  locator.registerFactory<UserPerository>(
    () => UserPerository(),
  );
  locator.registerFactory<ComplimantRepository>(
    () => ComplimantRepository(),
  );
  locator.registerFactory<MemoryRepository>(
    () => MemoryRepository(),
  );
  locator.registerFactory<SpecialDateRepository>(
    () => SpecialDateRepository(),
  );
  locator.registerFactory<CoupleRepository>(
    () => CoupleRepository(),
  );
}

void _setUpSQLite() async {
  SqliteDataBaseOpenHelper sqliteDataBaseOpenHelper =
      SqliteDataBaseOpenHelper();
  Database database = await sqliteDataBaseOpenHelper.initDatabase();
  locator.registerFactory<SqliteMemoryRepository>(
    () => SqliteMemoryRepository(database),
  );
  locator.registerFactory<SqliteDateRepository>(
    () => SqliteDateRepository(database),
  );
}

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
