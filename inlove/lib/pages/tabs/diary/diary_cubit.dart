import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:inlove/models/memory_model.dart';
import 'package:inlove/repository/memory_repository.dart';

import '../../../helpers/shared_preferences.dart';
import '../../../injector.dart';
import '../../../models/entities/internet_connection.dart';
import '../../../models/user_model.dart';
import '../../../repository/entity_repository.dart';
import 'diary_state.dart';

import 'dart:async';
import 'package:async/async.dart';
import 'package:path/path.dart';

class DiaryCubit extends Cubit<DiaryState> {
  DiaryCubit()
      : super(
          DiaryState(
            coupleMemorys: [],
          ),
        );
  final _user = locator.get<User>();
  final _internetConnection = locator.get<InternetConnection>();
  final _sharedPreferencesProvider = locator.get<SharedPreferencesProvider>();
  final _memoryRepository = locator.get<MemoryRepository>();

  final _sqliteMemoryRepository = locator.get<SqliteMemoryRepository>();

  void initState() {
    if (_user.coupleId != null) {
      _internetConnection.status ? getCoupleMemorys() : getLocalCoupleMemorys();
    }
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
    final memorys = await _memoryRepository.getCoupleMemorys(_user.coupleId!);

    emit(
      state.copyWith(coupleMemorys: memorys),
    );
  }

  void getLocalCoupleMemorys() async {
    final coupleId = _sharedPreferencesProvider.getCoupleId();
    List<Memory> memorys =
        await _sqliteMemoryRepository.getEntityList(coupleId);
    emit(
      state.copyWith(coupleMemorys: memorys),
    );
  }

  void addToLocalStorage(Memory memory) {
    _sqliteMemoryRepository.insert(memory, _user.coupleId!);
  }

  void upload(File imageFile) async {
    // open a bytestream
    var stream = ByteStream(DelegatingStream(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("${_internetConnection.localHost}/upload");

    // create multipart request
    var request = MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = MultipartFile('myFile', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      debugPrint(value);
    });
  }

  Future<String> uploadPhoto() async {
    return 'success';
  }
}
