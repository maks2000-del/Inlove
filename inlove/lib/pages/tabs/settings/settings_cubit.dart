import 'package:flutter_bloc/flutter_bloc.dart';
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
          ),
        );

  void initState() async {
    emit(
      state.copyWith(),
    );
  }

  User getUserById(int userId) {
    final user = User(
      id: 0,
      parthnerId: 0,
      name: '',
      email: '',
      password: '',
      sex: sexes.male,
    );
    return user;
  }

  List<String> getListOfUsersNames() {
    final List<String> usersNames = [];
    final List<User> test = [];
    for (final user in test) {
      usersNames.add(user.name);
    }
    return usersNames;
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
