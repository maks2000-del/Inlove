import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inlove/models/user_model.dart';
import 'package:inlove/pages/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(
          HomeState(
            title: '',
            pageIndex: 0,
          ),
        );

  void initState() async {
    emit(
      state.copyWith(),
    );
  }

  void setTab(int tanIdex) {}
}
