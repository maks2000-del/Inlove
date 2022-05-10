import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:inlove/components/button.dart';
import 'package:lottie/lottie.dart';

import '../../../components/input_autocomplete.dart';
import '../../../injector.dart';
import '../../../models/entities/internet_connection.dart';
import '../../../models/user_model.dart';
import 'settings_cubit.dart';
import 'settings_state.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  final internetConnection = locator.get<InternetConnection>();

  final _settingsCubit = GetIt.instance.get<SettingsCubit>();
  final _user = GetIt.instance.get<User>();

  @override
  void initState() {
    super.initState();
    final sex = _user.sex == sexes.male ? "male" : "female";
    if (_user.coupleId == null) {
      _settingsCubit.initState(null, sex);
    } else {
      _settingsCubit.initState(_user.coupleId, sex);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return BlocBuilder<SettingsCubit, SettingsState>(
      bloc: _settingsCubit,
      builder: (context, state) {
        return Scaffold(
          appBar: NeumorphicAppBar(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
          ),
          body: internetConnection.status
              ? Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      state.isPathnerChosen
                          ? parthnersInfoBlock(
                              cubit: _settingsCubit,
                              user: _user,
                              size: _size,
                              state: state,
                            )
                          : findParthnerBlock(
                              cubit: _settingsCubit,
                              user: _user,
                              size: _size,
                              state: state,
                            ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      simpleButton(
                        _size,
                        "LogOut",
                        10,
                        () => {
                          GetIt.instance.unregister<User>(),
                          Navigator.pushNamed(context, "/"),
                        },
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Lottie.asset(
                    'assets/lottieJSON/no_internet.json',
                    width: 380,
                    height: 380,
                  ),
                ),
        );
      },
    );
  }
}

Widget parthnersInfoBlock({
  required SettingsCubit cubit,
  required SettingsState state,
  required User user,
  required Size size,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(
      vertical: 0.0,
      horizontal: 20.0,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            user.sex == sexes.male
                ? const Icon(Icons.man)
                : const Icon(Icons.woman),
            const Text(" User: "),
            Text(user.name),
          ],
        ),
        Row(
          children: [
            user.sex == sexes.male
                ? const Icon(Icons.woman)
                : const Icon(Icons.man),
            const Text(" Your parthner is: "),
            Text(state.parthnerName),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.supervised_user_circle),
            const Text(" Your couple status is: "),
            Text(state.coupleStatus),
          ],
        ),
      ],
    ),
  );
}

Widget findParthnerBlock({
  required SettingsCubit cubit,
  required User user,
  required Size size,
  required SettingsState state,
}) {
  return state.isWaitingForRequest
      ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text('You have request from: '),
                Text(state.parthnerName),
              ],
            ),
            simpleButton(
              size,
              'Accept',
              0.0,
              () async {
                final status = await cubit.acceptCoupleRequest(user.coupleId!);
                Fluttertoast.showToast(msg: status);
              },
            ),
          ],
        )
      : Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            autocompleteTextfield(state.shortUsers, cubit),
            const SizedBox(
              height: 30.0,
            ),
            simpleButton(
              size,
              'Request',
              20.0,
              () async {
                final status = await cubit.sendCoupleRequest();
                Fluttertoast.showToast(msg: status);
              },
            ),
          ],
        );
}
