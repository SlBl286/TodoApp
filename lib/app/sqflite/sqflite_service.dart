import 'package:flutter/cupertino.dart';
import 'package:flutter_app/app/models/task.dart';
import 'package:flutter_app/app/sqflite/database.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteService {
  BuildContext? _context;
  SqfliteService(BuildContext? context) {
    _context = context;
  }

  Future<List<Task>> getTaskByDate(DateTime date) async {
    var db = await SqfliteDB.instance.dataBase;
    var rawData = await db.query("task_table");

    return rawData.map((e) => Task.fromJson(e)).toList();
  }

  Future<int> insertTask(Task task) async {
    int insertedId = 0;
    var db = await SqfliteDB.instance.dataBase;
    try {
      await db.transaction(
        (txn) async {
          insertedId = await txn.insert(
            "task_table",
            task.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        },
      );
    } catch (e) {
      print(e);
      return 0;
    }
    return insertedId;
  }

  Future<bool> deleteTask(int id) async {
    bool success = false;
    var db = await SqfliteDB.instance.dataBase;
    try {
      await db.transaction(
        (txn) async {
          var deletedCount =
              await txn.delete("task_table", where: "id = ?", whereArgs: [id]);
          if (deletedCount > 0) success = true;
        },
      );
    } catch (e) {
      print(e);
      return false;
      ;
    }
    return success;
  }
}
