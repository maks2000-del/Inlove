import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:inlove/models/special_date_model.dart';

import '../interfaces/i_http.dart';
import '../models/entities/internet_connection.dart';

class SpecialDateRepository implements ICpecialDateHttp {
  final _internetConnection = GetIt.instance.get<InternetConnection>();
  @override
  Future<List<SpeicalDate>> getCoupleDates(int coupleId) async {
    final dates = <SpeicalDate>[];
    try {
      final response = await http.get(
        Uri.parse("${_internetConnection.localHost}/api/dates/$coupleId"),
      );
      if (response.statusCode == 200) {
        for (final date in jsonDecode(response.body)) {
          final speicalDate = SpeicalDate.fromJson(date);
          dates.add(speicalDate);
        }
      }
    } catch (e) {
      throw Exception(e);
    }
    return dates;
  }

  @override
  Future<bool> postDate(SpeicalDate date) async {
    final response = await http.post(
      Uri.parse('${_internetConnection.localHost}/api/date'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(date.toMap()),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
