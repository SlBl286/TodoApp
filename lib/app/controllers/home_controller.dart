import 'package:flutter/widgets.dart';
import 'package:flutter_app/app/notification/service.dart';
import 'package:flutter_app/app/sqflite/sqflite_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'controller.dart';

class HomeController extends Controller {
  late NotificationService notificationService;
  late SqfliteService sqfliteService;
  @override
  construct(BuildContext context) {
    notificationService = new NotificationService(context);
    sqfliteService = new SqfliteService(context);
    super.construct(context);
  }

  Future getTaskList(DateTime date) {
    return sqfliteService.getTaskByDate(date);
  }
 Future<bool> deleteTask(int id) {
    return sqfliteService.deleteTask(id);
    
  }
  Future showTestNoti() async {
    await notificationService.addScheduleNoti(
        title: "test noti", body: "aaaaa");
  }
}
