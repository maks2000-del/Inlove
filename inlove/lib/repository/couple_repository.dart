import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:inlove/models/couple_model.dart';

import '../interfaces/i_http.dart';
import '../models/entities/internet_connection.dart';

class CoupleRepository implements ICoupleHttp {
  final _internetConnection = GetIt.instance.get<InternetConnection>();

  @override
  Future<Couple?> getCouple(int id) async {
    try {
      http.Response coupleResponse = await http.get(
        Uri.parse("${_internetConnection.localHost}/api/couple/$id"),
      );
      if (coupleResponse.statusCode == 200) {
        final couple = Couple.fromJson(
          jsonDecode(coupleResponse.body),
          //_user.sex,
        );
        return couple;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(
        e.toString(),
      );
    }
  }

  @override
  Future<Couple?> getCoupleByUserId(int id) async {
    try {
      http.Response coupleResponse = await http.get(
        Uri.parse("${_internetConnection.localHost}/api/coupleById/$id"),
      );
      if (coupleResponse.statusCode == 200) {
        final couple = Couple.fromJson(
          jsonDecode(coupleResponse.body),
          //_user.sex,
        );
        return couple;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Couple?> postCouple(Couple couple) async {
    try {
      final coupleResponse = await http.post(
        Uri.parse('${_internetConnection.localHost}/api/couple'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          couple.toMap(
            coupleId: couple.id,
            status: couple.status,
            userId: couple.userId,
            parthnerId: couple.parthnerId,
            //userSex: _user.sex,
          ),
        ),
      );

      if (coupleResponse.statusCode == 200) {
        final couple = Couple.fromJson(
          jsonDecode(coupleResponse.body),
          //_user.sex,
        );
        return couple;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Couple?> putCouple(Couple couple) async {
    try {
      final coupleResponse = await http.put(
        Uri.parse('${_internetConnection.localHost}/api/couple/${couple.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'status': couple.status,
        }),
      );
      if (coupleResponse.statusCode == 200) {
        final couple = Couple.fromJson(
          jsonDecode(coupleResponse.body),
          //_user.sex,
        );
        return couple;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
