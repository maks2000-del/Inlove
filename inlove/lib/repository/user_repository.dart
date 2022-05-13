import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:inlove/models/entities/internet_connection.dart';
import 'package:inlove/models/entities/short_user.dart';
import 'package:inlove/models/user_model.dart';

import '../interfaces/i_http.dart';

import 'package:http/http.dart' as http;

class UserPerository implements IUserHttp {
  final _internetConnection = GetIt.instance.get<InternetConnection>();
  @override
  Future<User?> getUser(int id) async {
    try {
      final uesrResponse = await http.get(
        Uri.parse("${_internetConnection.localHost}/api/user/$id"),
      );

      if (uesrResponse.statusCode == 200) {
        final user = User.fromJson(jsonDecode(uesrResponse.body));
        return user;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<String?> postUser(Map<String, String> inputInfo) async {
    try {
      final registrationResponse = await http.post(
        Uri.parse('${_internetConnection.localHost}/api/user'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': inputInfo['name']!,
          'email': inputInfo['email']!,
          'password': inputInfo['passowrd']!,
          'sex': inputInfo['sex']!,
        }),
      );
      if (registrationResponse.statusCode == 200) {
        final response = jsonDecode(registrationResponse.body);
        return response['status'];
      } else {
        return null;
      }
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<ShortUser>> getListOfUsersNames() async {
    List<ShortUser> shortUsers = [];
    try {
      final response = await http.get(
        Uri.parse("${_internetConnection.localHost}/api/users"),
      );
      if (response.statusCode == 200) {
        for (final user in jsonDecode(response.body)) {
          shortUsers.add(ShortUser(id: user['id'], name: user['name']));
        }
      }

      return shortUsers;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<User?> authUser(String email, String password) async {
    try {
      final authResponse = await http.post(
        Uri.parse('${_internetConnection.localHost}/api/user/auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (authResponse.statusCode == 200) {
        final user = User.fromJson(jsonDecode(authResponse.body));
        return user;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
