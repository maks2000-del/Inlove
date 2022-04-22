import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injector.dart';
import '../../../repository/user_repository.dart';
import 'diary_state.dart';

class DiaryCubit extends Cubit<DiaryState> {
  DiaryCubit()
      : super(
          DiaryState(
            memoryId: 0,
          ),
        );

  void initState() async {
    final userPerository = locator.get<UserPerository>();

    emit(
      state.copyWith(),
    );
  }

  Future<String> addNewMemory(
    String memoryTitle,
    String memoryDescription,
    String memoryLocation,
    DateTime dateTime,
    String? photoPath,
  ) async {
    return 'Memory has been added';
  }

  Future<String> uploadPhoto() async {
    return 'success';
  }
}
