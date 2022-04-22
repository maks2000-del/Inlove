import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:inlove/components/button.dart';

import '../../../components/input_autocomplete.dart';
import '../../../models/user_model.dart';
import 'settings_cubit.dart';
import 'settings_state.dart';

class SettingsTab extends StatelessWidget {
  final _settingsCubit = GetIt.instance.get<SettingsCubit>();
  final _user = GetIt.instance.get<User>();

  SettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return BlocBuilder<SettingsCubit, SettingsState>(
      bloc: _settingsCubit,
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              state.isPathnerChosen
                  ? parthnersInfo(
                      cubit: _settingsCubit, user: _user, size: _size)
                  : parthnersFinder(
                      cubit: _settingsCubit,
                      user: _user,
                      size: _size,
                    ),
            ],
          ),
        );
      },
    );
  }
}

Widget parthnersInfo({
  required SettingsCubit cubit,
  required User user,
  required Size size,
}) {
  return Column(
    children: [
      Text(
        'Your parthner is ${cubit.getUserById(user.parthnerId).name}',
      ),
      simpleButton(
        size,
        'CHANGE',
        20.0,
        () {},
      ),
    ],
  );
}

Widget parthnersFinder({
  required SettingsCubit cubit,
  required User user,
  required Size size,
}) {
  return Row(
    children: [
      autocompleteTextfield(cubit.getListOfUsersNames()),
      simpleButton(
        size,
        'APPLY',
        20.0,
        () {},
      ),
    ],
  );
}
