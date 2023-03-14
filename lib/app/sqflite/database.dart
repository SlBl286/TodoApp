import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDB {
  static final SqfliteDB instance = SqfliteDB._init();

  static Database? _dataBase;
  static const String _dbPath = 'todoapp.db';
  SqfliteDB._init();

  Future<Database> get dataBase async {
    if (_dataBase != null) return _dataBase!;

    _dataBase = await _initDB(_dbPath);
    return _dataBase!;
  }

  Future<Database> _initDB(String filePath) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, filePath);
    // await deleteDatabase(path);
    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  Future clearDB() async {
    if (_dataBase != null) {}
  }

  Future _onCreateDB(Database db, int version) async {
    //? DATA TYPE
    const idType = ' INTEGER PRIMARY KEY AUTOINCREMENT';
    const uNique = ' UNIQUE';
    // const notNull = ' NOT NULL';
    const textType = 'TEXT';
    const intType = 'INTEGER';
    const boolType = 'INTEGER';
    const doubleType = "REAL";
    await db.execute('''
      CREATE TABLE task_table (
        id $idType,
        title STRING,
        note TEXT,
        date STRING,
        start_time STRING,
        end_time STRING,
        remind INTEGER,
        repeat STRING,
        color INTEGER,
        is_completed INTEGER
       )
    ''');
  }

  Future close() async {
    final db = await instance.dataBase;
    db.close();
  }
}
