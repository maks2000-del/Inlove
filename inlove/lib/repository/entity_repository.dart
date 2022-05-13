import 'package:sqflite/sqflite.dart';

import '../helpers/sqlite_helper.dart';
import '../interfaces/i_http.dart';
import '../models/memory_model.dart';
import '../models/special_date_model.dart';

class SqliteMemoryRepository extends IEntityLocal<Memory> {
  late final Database database;

  SqliteMemoryRepository(this.database);

  @override
  Future<List<Memory>> getEntityList(int coupleId) async {
    final memorysList = <Memory>[];
    final dbMemorysList = await database.rawQuery(
      'SELECT * FROM $tableMemorys WHERE $columnCoupleId = ?',
      [coupleId],
    );
    for (final dbPage in dbMemorysList) {
      var mempry = Memory.fromSqliteEntitty(dbPage);
      memorysList.add(mempry);
    }
    return memorysList;
  }

  @override
  void insert(Memory entity, int coupleId) async {
    database.insert(
      tableMemorys,
      entity.toMapForLocalDB(),
    );
  }
}

class SqliteDateRepository extends IEntityLocal<SpeicalDate> {
  late final Database database;

  SqliteDateRepository(this.database);

  @override
  Future<List<SpeicalDate>> getEntityList(int coupleId) async {
    final datesList = <SpeicalDate>[];
    final dbDatesList = await database.rawQuery(
      'SELECT * FROM $tableDates WHERE $columnCoupleId = ?',
      [coupleId],
    );
    for (final dbDate in dbDatesList) {
      final note = SpeicalDate.fromSqliteEntitty(dbDate);
      datesList.add(note);
    }
    return datesList;
  }

  @override
  void insert(SpeicalDate entity, int coupleId) async {
    database.insert(
      tableDates,
      entity.toMapForLocalDB(),
    );
  }
}
