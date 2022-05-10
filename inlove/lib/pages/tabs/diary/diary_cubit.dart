import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:inlove/models/memory_model.dart';
import 'package:inlove/repository/sqlite_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helpers/shared_preferences.dart';
import '../../../injector.dart';
import '../../../models/entities/internet_connection.dart';
import '../../../models/user_model.dart';
import 'diary_state.dart';

class DiaryCubit extends Cubit<DiaryState> {
  DiaryCubit()
      : super(
          DiaryState(
            coupleMemorys: [],
          ),
        );
  final internetConnection = locator.get<InternetConnection>();

  final user = locator.get<User>();
  final sqliteMemoryRepository = locator.get<SqliteMemoryRepository>();

  void initState() {
    internetConnection.status ? getCoupleMemorys() : getLocalCoupleMemorys();

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

  void getCoupleMemorys() async {
    List<Memory> memorys = [];
    try {
      Response response = await get(
          Uri.parse("http://10.0.2.2:3001/api/memorys/${user.coupleId}"));
      if (response.statusCode == 200) {
        for (final memoryData in jsonDecode(response.body)) {
          final memory = Memory.fromJson(memoryData);
          memorys.add(memory);
        }
      }
      emit(
        state.copyWith(coupleMemorys: memorys),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getLocalCoupleMemorys() async {
    //TODO getIt
    final prefs = await SharedPreferences.getInstance();
    final sp = SharedPreferencesProvider(prefs);
    List<Memory> memorys =
        await sqliteMemoryRepository.getEntityList(sp.getCoupleId());
    emit(
      state.copyWith(coupleMemorys: memorys),
    );
  }

  void addToLocalStorage(Memory memory) {
    sqliteMemoryRepository.insert(memory, user.coupleId!);
  }

  void pickPhoto(File photo) {
    final newPickedPhoto = photo;
    emit(
      state.copyWith(pickedPhoto: newPickedPhoto),
    );
  }

  Future<String> uploadPhoto() async {
    return 'success';
  }
}
