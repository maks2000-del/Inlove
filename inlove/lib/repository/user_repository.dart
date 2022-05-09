import 'dart:convert';

import 'package:inlove/models/user_model.dart';

import '../helpers/http_helper.dart';
import '../interfaces/i_http.dart';

import 'package:http/http.dart' as http;

class UserPerository implements IHttp<User> {
  @override
  Future<User> get() async {
    final url = Uri.parse(HttpHelper.getPlatformLocalhost());
    http.Response response = await http.get(url);
    final user = User.fromJson(response.body as Map<String, dynamic>);
    return user;
  }

  @override
  Future<User> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<User> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<User> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }
}
