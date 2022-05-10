import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:inlove/models/entities/short_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helpers/shared_preferences.dart';
import '../../../injector.dart';
import '../../../models/user_model.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(
          SettingsState(
            isPathnerChosen: false,
            isWaitingForRequest: false,
            parthnerName: "unaccepted",
            coupleStatus: "none",
            shortUsers: [],
          ),
        );

  final _user = GetIt.instance.get<User>();

  void initState(int? coupleId, String userSex) async {
    final newStatus = await getCoupleStatus(_user.id);
    emit(
      state.copyWith(coupleStatus: newStatus),
    );
    switch (state.coupleStatus) {
      case "none":
        {}
        break;

      case "request":
        {
          emit(
            state.copyWith(isWaitingForRequest: true),
          );
          final parthnerId = await getUsersParthnerId(coupleId!, userSex);
          getParthnersName(parthnerId);
        }
        break;
      case "accepted":
        {
          final parthnerId = await getUsersParthnerId(coupleId!, userSex);
          getParthnersName(parthnerId);
          bool newParthnerStatus = true;
          emit(
            state.copyWith(isPathnerChosen: newParthnerStatus),
          );
          try {
            //TODO getIt
            final prefs = await SharedPreferences.getInstance();
            final sp = SharedPreferencesProvider(prefs);
            sp.setCoupleId(_user.coupleId!);
          } catch (e) {
            throw Exception(e);
          }
        }
        break;

      default:
        {}
        break;
    }

    final names = await getListOfUsersNames();
    emit(
      state.copyWith(shortUsers: names),
    );
  }

  Future<List<ShortUser>> getListOfUsersNames() async {
    List<ShortUser> shortUsers = [];
    try {
      Response response =
          await get(Uri.parse("http://10.0.2.2:3001/api/users"));
      for (final user in jsonDecode(response.body)) {
        shortUsers.add(ShortUser(id: user['id'], name: user['name']));
      }
      return shortUsers;
    } catch (e) {
      return <ShortUser>[];
    }
  }

  Future<String> getCoupleStatus(int userId) async {
    try {
      Response coupleResponse =
          await get(Uri.parse("http://10.0.2.2:3001/api/coupleById/$userId"));

      if (coupleResponse.statusCode == 200) {
        Map<String, dynamic> couple = jsonDecode(coupleResponse.body);
        return couple['status'];
      } else if (coupleResponse.statusCode == 404) {
        return "none";
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int> getUsersParthnerId(int coupleId, userSex) async {
    int parthnerId;
    try {
      Response coupleResponse =
          await get(Uri.parse("http://10.0.2.2:3001/api/couple/$coupleId"));
      Map<String, dynamic> couple = jsonDecode(coupleResponse.body);
      if (coupleResponse.statusCode == 200) {
        final newCoupleStatus = couple['status'];
        emit(
          state.copyWith(coupleStatus: newCoupleStatus),
        );
        userSex == "male"
            ? parthnerId = couple['girl_id']
            : parthnerId = couple['boy_id'];
        return parthnerId;
      }
      throw Exception();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void setParthnerId(int parthnerId) {
    emit(
      state.copyWith(parthnerId: parthnerId),
    );
  }

  void getParthnersName(int id) async {
    try {
      Response uesrResponse =
          await get(Uri.parse("http://10.0.2.2:3001/api/user/$id"));
      Map<String, dynamic> user = jsonDecode(uesrResponse.body);
      if (uesrResponse.statusCode == 200) {
        final newParthnersName = user['name'];
        emit(
          state.copyWith(parthnerName: newParthnersName),
        );
      }
      throw Exception();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> sendCoupleRequest() async {
    if (state.parthnerId != null) {
      late int boyId, girlId;
      _user.sex == sexes.male
          ? {boyId = _user.id, girlId = state.parthnerId!}
          : {boyId = state.parthnerId!, girlId = _user.id};
      try {
        final coupleResponse = await post(
          Uri.parse('http://10.0.2.2:3001/api/couple'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'boyId': boyId.toString(),
            'girlId': girlId.toString(),
            'status': "request",
          }),
        );

        if (coupleResponse.statusCode == 200) {
          Map<String, dynamic> couple = jsonDecode(coupleResponse.body);
          final newCoupleStatus = couple['status'];
          emit(
            state.copyWith(coupleStatus: newCoupleStatus),
          );
          final user = _user.copyWith(coupleId: couple['id']);
          GetIt.instance.unregister<User>();
          GetIt.instance.registerSingleton<User>(
            User(
              id: user.id,
              coupleId: user.coupleId,
              name: user.name,
              email: user.email,
              sex: user.sex,
            ),
          );
          emit(
            state.copyWith(isPathnerChosen: true),
          );
          final prefs = await SharedPreferences.getInstance();
          final sp = SharedPreferencesProvider(prefs);
          sp.setCoupleId(user.coupleId!);
          return "sent";
        } else {
          return "error";
        }
      } catch (e) {
        throw Exception(e.toString());
      }
    } else {
      return "choose parthner";
    }
  }

  Future<String> acceptCoupleRequest(int coupleId) async {
    try {
      final coupleResponse = await put(
        Uri.parse('http://10.0.2.2:3001/api/couple/$coupleId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'status': "accepted",
        }),
      );
      if (coupleResponse.statusCode == 200) {
        Map<String, dynamic> couple = jsonDecode(coupleResponse.body);
        final newCoupleStatus = couple['status'];
        emit(
          state.copyWith(coupleStatus: newCoupleStatus),
        );
        bool newParthnerStatus = true;
        emit(
          state.copyWith(isPathnerChosen: newParthnerStatus),
        );
        return "accepted";
      } else {
        return "error";
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
