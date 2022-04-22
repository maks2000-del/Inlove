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
}
