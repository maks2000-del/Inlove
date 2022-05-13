import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:inlove/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/shared_preferences.dart';
import '../../models/user_model.dart';
import '../../repository/couple_repository.dart';
import 'authentication_state.dart';

class AuthorizationCubit extends Cubit<AuthorizationState> {
  AuthorizationCubit()
      : super(
          AuthorizationState(
            showAuthorizationComponent: true,
            toggleSex: 0,
          ),
        );

  void initState() async {
    emit(
      state.copyWith(),
    );
  }

  void switchRegAuthComponent() {
    final oppositeShowAuthorizationComponent =
        !state.showAuthorizationComponent;
    emit(
      state.copyWith(
          showAuthorizationComponent: oppositeShowAuthorizationComponent),
    );
  }

  void switchToggleSex(int selectedIndex) {
    emit(
      state.copyWith(toggleSex: selectedIndex),
    );
  }

  Future<SharedPreferencesProvider> registerSharedPreferences() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final sharedPreferencesProvider =
          SharedPreferencesProvider(sharedPreferences);
      GetIt.instance.registerFactory<SharedPreferencesProvider>(
        () => SharedPreferencesProvider(sharedPreferences),
      );
      return sharedPreferencesProvider;
    } catch (e) {
      return GetIt.instance.get<SharedPreferencesProvider>();
    }
  }

  void localAuth({
    required String mail,
    required String password,
    required SharedPreferencesProvider sp,
    required VoidCallback openMainPage,
  }) {
    final _spId = sp.getUserId();
    final _spMail = sp.getUserMail();
    final _spPass = sp.getUserPass();
    final _spName = sp.getUserName();
    final _spSex = sp.getUserSex();
    if (_spMail == mail && _spPass == password) {
      GetIt.instance.registerSingleton<User>(
        User(
          id: _spId,
          name: _spName,
          email: _spMail,
          sex: _spSex == "male" ? sexes.male : sexes.female,
        ),
      );
      openMainPage();
    }
  }

  void internetAuth({
    required String mail,
    required String password,
    required UserPerository userPerository,
    required CoupleRepository coupleRepository,
    required SharedPreferencesProvider sp,
    required VoidCallback openMainPage,
  }) async {
    final user = await userPerository.authUser(mail, password);
    if (user != null) {
      GetIt.instance.registerSingleton<User>(
        User(
          id: user.id,
          name: user.name,
          email: user.email,
          sex: user.sex,
        ),
      );
      final couple = await coupleRepository.getCoupleByUserId(user.id);
      if (couple != null) {
        GetIt.instance.unregister<User>();
        GetIt.instance.registerSingleton<User>(
          User(
            id: user.id,
            coupleId: couple.id,
            name: user.name,
            email: user.email,
            sex: user.sex,
          ),
        );
      }
      try {
        sp.setUserId(user.id);
        sp.setUserName(user.name);
        sp.setUserSex(user.sex == sexes.male ? "male" : "female");
        sp.setUserMail(mail);
        sp.setUserPass(password);
      } catch (e) {
        throw Exception();
      }
      openMainPage();
    } else {
      Fluttertoast.showToast(msg: 'Check your email or password');
      throw Exception('Failed to auth user.');
    }
  }

  void registerUser(
    String name,
    String mail,
    String password,
    String repeatedRassword,
    UserPerository userRepo,
  ) async {
    if (name.length > 1 && mail.length > 1 && password == repeatedRassword) {
      final inputInfo = {
        "name": name,
        "email": mail,
        "passowrd": password,
        "sex": state.toggleSex == 0 ? "male" : "female",
      };
      final registrationStatus = await userRepo.postUser(inputInfo);
      if (registrationStatus != null) {
        if (registrationStatus == 'registered') {
          Fluttertoast.showToast(
            msg: 'User $name have been registered',
          );
          switchRegAuthComponent();
        }
      }
    } else {
      Fluttertoast.showToast(msg: 'Uncorrect fields');
    }
  }
}
