import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inlove/models/user_model.dart';

import 'authentication_state.dart';

class AuthorizationCubit extends Cubit<AuthorizationState> {
  AuthorizationCubit()
      : super(
          AuthorizationState(
            user: User(
              id: 0,
              parthnerId: 0,
              name: '',
              email: '',
              password: '',
              sex: sexes.male,
            ),
            showAuthorizationComponent: true,
            toggleSex: 0,
          ),
        );

  void initState() async {
    checkForInternetConnection();
    emit(
      state.copyWith(),
    );
  }

  void checkForInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
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
}
