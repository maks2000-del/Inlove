enum sexes {
  male,
  female,
}

class User {
  final String name;
  final String email;
  final String password;
  final sexes sex;

  User(this.name, this.email, this.password, this.sex);
}
