import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:inlove/models/user_model.dart';

import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(
          SettingsState(
            usersParthner: User(
              id: 0,
              parthnerId: 0,
              name: '',
              email: '',
              password: '',
              sex: sexes.male,
            ),
            isPathnerChosen: false,
            userNames: [],
          ),
        );

  void initState() async {
    final names = await getListOfUsersNames();
    emit(
      state.copyWith(userNames: names),
    );
  }

  Future<List<String>> getListOfUsersNames() async {
    List<String> userNames = [];
    try {
      Response response =
          await get(Uri.parse("http://10.0.2.2:3001/api/users"));
      for (final user in jsonDecode(response.body)) {
        userNames.add(user['name']);
      }
      return userNames;
    } catch (e) {
      return <String>[];
    }
  }

  User findUserByName(String name) {
    User userByName = User(
      id: 0,
      parthnerId: 0,
      name: '',
      email: '',
      password: '',
      sex: sexes.male,
    );
    final List<User> test = [];
    for (final user in test) {
      if (user.name == name) {
        userByName = user;
        break;
      }
    }
    return userByName;
  }

  void setUsersParthner() {}
}
