import 'package:inlove/models/memory_model.dart';
import 'package:inlove/models/special_date_model.dart';

import '../models/couple_model.dart';

import '../models/entities/short_user.dart';
import '../models/user_model.dart';

abstract class IEntityLocal<T> {
  void insert(T entity, int coupleId);
  Future<List<T>> getEntityList(int coupleId);
}

abstract class IUserHttp {
  Future<User?> getUser(int id);
  Future<User?> authUser(String email, String password);
  Future<String?> postUser(Map<String, String> inputInfo);
  Future<List<ShortUser>> getListOfUsersNames();
}

abstract class ICoupleHttp {
  Future<Couple?> getCouple(int id);
  Future<Couple?> getCoupleByUserId(int userId);
  Future<Couple?> postCouple(Couple couple);
  Future<Couple?> putCouple(Couple couple);
}

abstract class IComplimentHttp {
  Future<String?> getCompliment(
    int userId,
    DateTime dateToShow,
    sexes userSex,
  );
}

abstract class IMemoryHttp {
  Future<bool> postMemory(Memory memory);
  Future<List<Memory>> getCoupleMemorys(int coupleId);
}

abstract class ICpecialDateHttp {
  Future<bool> postDate(SpeicalDate date);
  Future<List<SpeicalDate>> getCoupleDates(int coupleId);
}
