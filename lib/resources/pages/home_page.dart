import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/constants/dropdown_data.dart';
import 'package:flutter_app/app/models/task.dart';
import 'package:flutter_app/bootstrap/extensions.dart';
import 'package:flutter_app/config/font.dart';
import 'package:flutter_app/config/theme.dart';
import 'package:flutter_app/resources/pages/add_task_page.dart';
import 'package:flutter_app/resources/widgets/add_button_widget.dart';
import 'package:flutter_app/resources/widgets/logo_widget.dart';
import 'package:flutter_app/resources/widgets/task_tile.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
  final DatePickerController _datePickerController = DatePickerController();
  List<Task> _tasks = [];
  @override
  init() async {
    super.init();
    _getData();
  }

  _getData() async {
    _tasks = await widget.controller.getTaskList(_selectedDate);
    setState(() {});
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
          _taskList(),
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

  _showBottomSheet(BuildContext context, Task task) async {
    showBottomSheet(
        context: context,
        builder: (context) {
          return Container();
        });
  }

  Widget _taskList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, i) {
          var item = _tasks[i];
          return AnimationConfiguration.staggeredList(
            position: i,
            child: SlideAnimation(
              child: FadeInAnimation(
                child: Row(
                  children: [
                    Slidable(
                      startActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            // An action can be bigger than the others.
                            flex: 1,
                            onPressed: (context) {},
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,

                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12)),
                            icon: Icons.delete,
                            label: 'Xóa',
                          ),
                          SlidableAction(
                            onPressed: (context) {},
                            backgroundColor:
                                ThemeColor.get(context).buttonBackgroundPrimary,
                            foregroundColor: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12)),
                            icon: Icons.done,
                            label: 'Hoàn thành',
                          ),
                        ],
                      ),
                      child: TaskTile(
                        task: item,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _dateBar() {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 90,
        width: (MediaQuery.of(context).size.width - 20) / 5,
        initialSelectedDate: _selectedDate,
        selectionColor: ThemeColor.get(context).buttonBackgroundPrimary,
        dateTextStyle: GoogleFonts.lato(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        dayTextStyle: GoogleFonts.lato(
            fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        monthTextStyle: GoogleFonts.lato(
            fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey),
        controller: _datePickerController,
        onDateChange: (selectedDate) {
          setState(() {
            _selectedDate = selectedDate;
          });
        },
        locale: "vi_VN",
      ),
    );
  }

  Widget _taskBar() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              // setState(
              //   () => _selectedDate = DateTime.now(),
              // );
              // _datePickerController.animateToDate(DateTime.now());
              widget.controller.showTestNoti();
            },
            child: Container(
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
          ),
          AddButton(
            label: "+ Thêm mới",
            onTap: () async {
              await routeTo(
                AddTaskPage().route,
                onPop: (inserted) {
                  if (inserted != null) {
                    _getData();
                    showToast(
                      style: ToastNotificationStyleType.SUCCESS,
                      title: "Thêm Thành công",
                      description: "Đã thêm task $inserted",
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
