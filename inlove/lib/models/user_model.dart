// ignore: camel_case_types
enum sexes {
  male,
  female,
}

class User {
  final int id;
  final int? parthnerId;
  final int? coupleId;
  final String name;
  final String email;
  final String? password;
  final sexes sex;
  final bool? isAuthorized;

  User({
    required this.id,
    this.parthnerId,
    this.coupleId,
    required this.name,
    required this.email,
    this.password,
    required this.sex,
    this.isAuthorized,
  });

  User copyWith({
    int? id,
    int? parthnerId,
    int? coupleId,
    String? name,
    String? email,
    String? password,
    sexes? sex,
    bool? isAuthorized,
  }) {
    return User(
      id: id ?? this.id,
      parthnerId: parthnerId ?? this.parthnerId,
      coupleId: coupleId ?? this.coupleId,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      sex: sex ?? this.sex,
      isAuthorized: isAuthorized ?? this.isAuthorized,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        sex: json['sex'] == "male" ? sexes.male : sexes.female,
      );

  Map<String, dynamic> toMap(User user) {
    return {
      'id': user.id,
      'name': user.name,
      'email': user.email,
      'password': user.password,
      'sex': user.sex,
    };
  }
}
