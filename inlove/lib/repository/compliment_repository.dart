import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:inlove/interfaces/i_http.dart';
import 'package:inlove/models/user_model.dart';

import '../models/entities/internet_connection.dart';

class ComplimantRepository implements IComplimentHttp {
  final _internetConnection = GetIt.instance.get<InternetConnection>();

  @override
  Future<String> getCompliment(
    int userId,
    DateTime dateToShow,
    sexes userSex,
  ) async {
    try {
      final date = dateToShow.toString().substring(0, 10);
      final sex = userSex == sexes.male ? "male" : "female";
      http.Response complimentResponse = await http.get(
        Uri.parse(
          "${_internetConnection.localHost}/api/compliment/couple/$userId.$date.$sex",
        ),
      );

      if (complimentResponse.statusCode == 200) {
        Map<String, dynamic> copmliment = jsonDecode(complimentResponse.body);
        return copmliment['compliment_text'];
      } else {
        return 'Maybe next time :P';
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
