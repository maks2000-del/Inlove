import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:inlove/pages/authentication/authentication_cubit.dart';
import 'package:inlove/pages/home/home_cubit.dart';
import 'package:inlove/pages/tabs/calendar/calendar_cubir.dart';
import 'package:inlove/pages/tabs/diary/diary_cubit.dart';
import 'package:inlove/pages/tabs/settings/settings_cubit.dart';
import 'package:inlove/repository/sqlite_repository.dart';
import 'package:sqflite/sqflite.dart';

import 'models/entities/internet_connection.dart';
import 'repository/user_repository.dart';

final locator = GetIt.instance;

void setUp() {
  _setUpConnection();
  _setUpUserPerositories();
  _setUpCubits();
  _setUpSQLite();
}

void _setUpConnection() async {
  final connection = await checkForInternetConnection();
  locator.registerSingleton<InternetConnection>(
    InternetConnection(connection),
  );
}

void _setUpUserPerositories() {
  locator.registerFactory<UserPerository>(
    () => UserPerository(),
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

Future<bool> checkForInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}
