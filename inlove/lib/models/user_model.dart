import 'package:flutter/foundation.dart';

enum sexes {
  male,
  female,
}

class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final sexes sex;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.sex,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        sex: json['sex'] as sexes,
      );
}
