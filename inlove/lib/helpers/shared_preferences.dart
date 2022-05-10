import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider {
  late final SharedPreferences spInstance;

  SharedPreferencesProvider(this.spInstance);

  void setUserId(int userId) async {
    await spInstance.setInt('user_id', userId);
  }

  void setCoupleId(int coupleId) async {
    await spInstance.setInt('couple_id', coupleId);
  }

  void setUserName(String userName) async {
    await spInstance.setString('user_name', userName);
  }

  void setUserMail(String userMail) async {
    await spInstance.setString('user_mail', userMail);
  }

  void setUserPass(String userPass) async {
    await spInstance.setString('user_pass', userPass);
  }

  void setUserSex(String userSex) async {
    await spInstance.setString('user_sex', userSex);
  }

  int getCoupleId() {
    try {
      spInstance.getInt('couple_id');
    } catch (e) {
      spInstance.setInt('couple_id', 0);
    }
    final coupleId = spInstance.getInt('couple_id');
    return coupleId!;
  }

  int getUserId() {
    try {
      spInstance.getInt('user_id');
    } catch (e) {
      spInstance.setInt('user_id', 0);
    }
    final userId = spInstance.getInt('user_id');
    return userId!;
  }

  String getUserPass() {
    try {
      spInstance.getString('user_pass');
    } catch (e) {
      spInstance.setString('user_pass', '');
    }
    final userPass = spInstance.getString('user_pass');
    return userPass!;
  }

  String getUserMail() {
    try {
      spInstance.getString('user_mail');
    } catch (e) {
      spInstance.setString('user_mail', '');
    }
    final userMail = spInstance.getString('user_mail');
    return userMail!;
  }

  String getUserName() {
    try {
      spInstance.getString('user_name');
    } catch (e) {
      spInstance.setString('user_name', '');
    }
    final userName = spInstance.getString('user_name');
    return userName!;
  }

  String getUserSex() {
    try {
      spInstance.getString('user_sex');
    } catch (e) {
      spInstance.setString('user_sex', '');
    }
    final userSex = spInstance.getString('user_sex');
    return userSex!;
  }
}
