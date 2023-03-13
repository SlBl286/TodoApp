import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/bootstrap/extensions.dart';
import 'package:flutter_app/config/font.dart';
import 'package:flutter_app/config/theme.dart';
import 'package:flutter_app/resources/pages/add_task_page.dart';
import 'package:flutter_app/resources/widgets/add_button_widget.dart';
import 'package:flutter_app/resources/widgets/logo_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '/app/controllers/home_controller.dart';
import '/bootstrap/helpers.dart';
import '/resources/widgets/safearea_widget.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:nylo_framework/theme/helper/ny_theme.dart';

class HomePage extends NyStatefulWidget {
  final HomeController controller = HomeController();

  HomePage({Key? key}) : super(key: key, routeName: "/home");

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends NyState<HomePage> {
  DateTime _selectedDate = DateTime.now();
  @override
  init() async {
    super.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: ThemeColor.get(context).background,
      body: Column(
        children: [
          _taskBar(),
          _dateBar(),
          Text(_selectedDate.toString()),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: ThemeColor.get(context).background,
      leading: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (!ThemeColor.get(context).isDarkTheme) {
            NyTheme.set(context, id: ThemeConfig.dark().id);
            print(ThemeConfig.dark().id);
          } else {
            NyTheme.set(context, id: ThemeConfig.light().id);
            print(ThemeConfig.light().id);
          }
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ThemeColor.get(context).isDarkTheme
              ? Image.asset(getImageAsset("sun.png"))
              : Image.asset(
                  getImageAsset("moon.png"),
                ),
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundColor: ThemeColor.get(context).primaryContent,
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Image.asset(getImageAsset("nylo_logo.png")),
          ),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  Widget _dateBar() {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 90,
        width: (MediaQuery.of(context).size.width - 20) / 5,
        initialSelectedDate: DateTime.now(),
        selectionColor: ThemeColor.get(context).buttonBackgroundPrimary,
        dateTextStyle: GoogleFonts.lato(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        dayTextStyle: GoogleFonts.lato(
            fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        monthTextStyle: GoogleFonts.lato(
            fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey),
        onDateChange: (selectedDate) {
          setState(() {
            _selectedDate = selectedDate;
          });
        },
      ),
    );
  }

  Widget _taskBar() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd("vi").format(_selectedDate),
                  style: GoogleFonts.lato(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: ThemeColor.get(context).primaryAccent,
                  ),
                ),
                Container(
                  height: 40,
                  child: Text(
                    _selectedDate.getWeekDayWithToday(),
                    style: GoogleFonts.lato(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: ThemeColor.get(context).primaryContent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AddButton(
            label: "+ Thêm mới",
            onTap: () {
              routeTo(AddTaskPage().route);
            },
          ),
        ],
      ),
    );
  }
}
