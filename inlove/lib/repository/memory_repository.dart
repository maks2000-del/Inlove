import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:inlove/interfaces/i_http.dart';
import 'package:inlove/models/memory_model.dart';

import '../models/entities/internet_connection.dart';

class MemoryRepository implements IMemoryHttp {
  final _internetConnection = GetIt.instance.get<InternetConnection>();

  @override
  Future<List<Memory>> getCoupleMemorys(int coupleId) async {
    List<Memory> memorys = [];
    try {
      http.Response response = await http.get(
        Uri.parse("${_internetConnection.localHost}/api/memorys/$coupleId"),
      );
      if (response.statusCode == 200) {
        for (final memoryData in jsonDecode(response.body)) {
          final memory = Memory.fromJson(memoryData);
          memorys.add(memory);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return memorys;
  }

  @override
  Future<bool> postMemory(Memory memory) async {
    try {
      final response = await http.post(
        Uri.parse('${_internetConnection.localHost}/api/memory'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(memory.toMap()),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception();
    }
  }
}
