import 'package:flutter_app/app/models/task.dart';
import 'package:flutter_app/app/sqflite/sqflite_service.dart';

import 'controller.dart';
import 'package:flutter/widgets.dart';

class AddTaskController extends Controller {
  late SqfliteService sqfliteService;
  construct(BuildContext context) {
    sqfliteService = new SqfliteService(context);
    super.construct(context);
  }

  Future addTask(Task task) async {
    return await sqfliteService.insertTask(task);
  }
}
