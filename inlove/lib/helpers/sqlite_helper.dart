import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
