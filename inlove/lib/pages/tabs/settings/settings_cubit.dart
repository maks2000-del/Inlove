import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:inlove/models/couple_model.dart';
import 'package:inlove/repository/user_repository.dart';

import '../../../helpers/shared_preferences.dart';
import '../../../injector.dart';
import '../../../models/user_model.dart';
import '../../../repository/couple_repository.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final _user = GetIt.instance.get<User>();
  final _userPerository = UserPerository();
  final _sharedPreferencesProvider = locator.get<SharedPreferencesProvider>();
  final _coupleRepository = locator.get<CoupleRepository>();

  SettingsCubit()
      : super(
          SettingsState(
            isPathnerChosen: false,
            isWaitingForRequest: false,
            parthnerName: "none",
            coupleStatus: "none",
            shortUsers: [],
          ),
        );

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
          final parthnerId = await getParthnerId(coupleId!, userSex);
          getParthnersName(parthnerId);
        }
        break;
      case "accepted":
        {
          final parthnerId = await getParthnerId(coupleId!, userSex);
          getParthnersName(parthnerId);
          bool newParthnerStatus = true;
          emit(
            state.copyWith(isPathnerChosen: newParthnerStatus),
          );
          try {
            _sharedPreferencesProvider.setCoupleId(_user.coupleId!);
          } catch (e) {
            throw Exception(e);
          }
        }
        break;

      default:
        {}
        break;
    }

    final shortUsers = await _userPerository.getListOfUsersNames();
    emit(
      state.copyWith(shortUsers: shortUsers),
    );
  }

  Future<String> getCoupleStatus(int userId) async {
    final couple = await _coupleRepository.getCoupleByUserId(userId);
    if (couple != null) {
      return couple.status;
    } else {
      return "none";
    }
  }

  Future<int> getParthnerId(int coupleId, userSex) async {
    final couple = await _coupleRepository.getCouple(coupleId);
    return couple!.parthnerId!;
  }

  void setParthnerId(int parthnerId) {
    emit(
      state.copyWith(parthnerId: parthnerId),
    );
  }

  void getParthnersName(int id) async {
    final user = await _userPerository.getUser(id);

    if (user != null) {
      final newParthnersName = user.name;
      emit(
        state.copyWith(parthnerName: newParthnersName),
      );
    }
  }

  Future<String> sendCoupleRequest() async {
    if (state.parthnerId != null) {
      final couple = Couple(
        null,
        "request",
        userId: _user.id,
        parthnerId: state.parthnerId!,
      );
      final newCouple = await _coupleRepository.postCouple(couple);
      emit(
        state.copyWith(
          coupleStatus: newCouple!.status,
          isPathnerChosen: true,
        ),
      );
      final user = _user.copyWith(
        coupleId: newCouple.id,
      );
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
      _sharedPreferencesProvider.setCoupleId(user.coupleId!);
      return "sent";
    } else {
      return "choose parthner";
    }
  }

  Future<String> acceptCoupleRequest(int coupleId) async {
    final couple = Couple(coupleId, 'accepted');

    final refreshedCouple = await _coupleRepository.putCouple(couple);
    emit(
      state.copyWith(
        coupleStatus: refreshedCouple!.status,
        isPathnerChosen: true,
      ),
    );

    return refreshedCouple.status;
  }
}
