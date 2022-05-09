import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inlove/pages/home/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(
          HomeState(
            title: '',
            tabIndex: 0,
          ),
        );

  void initState() async {
    emit(
      state.copyWith(),
    );
  }

  void setTab(int tabIdex) {
    final newTabIndex = tabIdex;
    emit(
      state.copyWith(tabIndex: newTabIndex),
    );
  }
}
