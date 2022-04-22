enum sexes {
  male,
  female,
}

class User {
  final int id;
  final int parthnerId;
  final String name;
  final String email;
  final String password;
  final sexes sex;

  User({
    required this.id,
    required this.parthnerId,
    required this.name,
    required this.email,
    required this.password,
    required this.sex,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        parthnerId: json['parthnerId'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
        sex: json['sex'] as sexes,
      );

  Map<String, dynamic> toMap(User user) {
    return {
      'id': user.id,
      'parthnerId': user.parthnerId,
      'name': user.name,
      'email': user.email,
      'password': user.password,
      'sex': user.sex,
    };
  }
}
