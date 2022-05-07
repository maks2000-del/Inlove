import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:inlove/models/memory_model.dart';

import '../../../injector.dart';
import '../../../models/user_model.dart';
import '../../../repository/user_repository.dart';
import 'diary_state.dart';

class DiaryCubit extends Cubit<DiaryState> {
  DiaryCubit()
      : super(
          DiaryState(
            coupleMemorys: [],
          ),
        );

  List<Memory> destinations = [
    Memory(
      id: 1,
      coupleId: 1,
      title: 'title',
      description: 'description',
      date: DateTime.now().toString(),
      location: 'location',
      photoId: 0,
    ),
    Memory(
      id: 1,
      coupleId: 1,
      title: 'title',
      description: 'description',
      date: DateTime.now().toString(),
      location: 'location',
      photoId: 0,
    ),
    Memory(
      id: 1,
      coupleId: 1,
      title: 'title',
      description: 'description',
      date: DateTime.now().toString(),
      location: 'location',
      photoId: 0,
    ),
  ];

  final user = locator.get<User>();

  void initState() {
    getCoupleDates();
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

  void getCoupleDates() async {
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
      print(e.toString());
    }
  }

  Future<String> uploadPhoto() async {
    return 'success';
  }
}
