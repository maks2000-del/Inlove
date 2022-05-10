import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/memory_model.dart';
import '../models/special_date_model.dart';
import 'entity_repository.dart';

const String tableDates = 'dates';
const String columnDateId = 'date_id';
const String columnCoupleId = 'couple_id';
const String columnTitle = 'title';
const String columnDate = 'date';
const String columnBgColour = 'bg_color_id';

const String tableMemorys = 'memorys';
const String columnMemoryId = 'memory_id';
const String columnDescription = 'description';
const String columnLocation = 'location';
const String columnPhotoPath = 'photo_path';

class SqliteDataBaseOpenHelper {
  Future<Database> initDatabase() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'main.db'),
      version: 1,
      onCreate: (db, version) {
        db.execute('''
         create table $tableDates(
        $columnDateId integer primary key autoincrement,
        $columnCoupleId integer not null,     
        $columnTitle text,
        $columnDate text,
        $columnBgColour integer)
       ''');
        db.execute('''
         create table $tableMemorys(
        $columnMemoryId integer primary key autoincrement,  
        $columnCoupleId integer not null,
        $columnTitle text,
        $columnDescription text,
        $columnDate text,
        $columnLocation text,
        $columnPhotoPath text) 
       ''');
      },
    );
    return database;
  }
}

class SqliteMemoryRepository extends IRepository<Memory> {
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
      var mempry = Memory.fromJson(dbPage);
      memorysList.add(mempry);
    }
    return memorysList;
  }

  @override
  void insert(Memory entity, int coupleId) async {
    database.insert(
      tableMemorys,
      entity.toMap(coupleId),
    );
  }
}

class SqliteDateRepository extends IRepository<SpeicalDate> {
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
      final note = SpeicalDate.fromJson(dbDate);
      datesList.add(note);
    }
    return datesList;
  }

  @override
  void insert(SpeicalDate entity, int coupleId) async {
    database.insert(
      tableDates,
      entity.toMap(coupleId),
    );
  }
}
