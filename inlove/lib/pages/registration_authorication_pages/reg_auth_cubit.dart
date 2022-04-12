import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inlove/models/user_model.dart';

import 'reg_auth_state.dart';

class RegAuthCubit extends Cubit<RegAuthState> {
  RegAuthCubit()
      : super(
          RegAuthState(
            user: User('', '', '', sexes.male),
          ),
        );

  void initState() async {
    emit(
      state.copyWith(),
    );
  }
}
