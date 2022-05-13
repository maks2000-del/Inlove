import 'package:get_it/get_it.dart';
import 'package:inlove/models/user_model.dart';

class Couple {
  int? id;
  int? userId;
  int? parthnerId;
  String status;

  Couple(this.id, this.status, {this.userId, this.parthnerId});

  factory Couple.fromJson(Map<String, dynamic> json) {
    final _user = GetIt.instance.get<User>();

    final int? userId, parthnerId;
    _user.sex == sexes.male
        ? {userId = json['boy_id'], parthnerId = json['girl_id']}
        : {userId = json['girl_id'], parthnerId = json['boy_id']};
    return Couple(
      json['id'],
      json['status'],
      userId: userId,
      parthnerId: parthnerId,
    );
  }

  Map<String, dynamic> toMap({
    int? coupleId,
    int? userId,
    int? parthnerId,
    required String status,
  }) {
    // final int? boyId, girlId;
    // userSex == sexes.male
    //     ? {boyId = userId, girlId = parthnerId}
    //     : {boyId = parthnerId, girlId = userId};
    return {
      'boyId': userId,
      'girlId': parthnerId,
      'status': status,
    };
  }
}
