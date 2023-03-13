import 'package:flutter/material.dart';
import 'package:flutter_app/bootstrap/helpers.dart';
import 'package:flutter_app/resources/widgets/generic_input_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '/app/controllers/add_task_controller.dart';

class AddTaskPage extends NyStatefulWidget {
  final AddTaskController controller = AddTaskController();

  AddTaskPage({Key? key}) : super(key: key, routeName: "/add-task");

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends NyState<AddTaskPage> {
  DateTime _seletecDate = DateTime.now();
  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now();
  int _selectedRemind = 5;
  String _selectedRepeat = "Không";
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];
  List<String> repeatList = [
    "Không",
    "Hàng ngày",
    "Hàng tuần",
    "Hàng tháng",
  ];
  @override
  init() async {
    super.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _form(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: ThemeColor.get(context).background,
      leading: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          pop();
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ThemeColor.get(context).primaryContent,
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

  Widget _title() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Text(
        "Thêm task",
        style: GoogleFonts.lato(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: ThemeColor.get(context).primaryContent,
        ),
      ),
    );
  }

  Widget _form() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Thêm task",
              style: GoogleFonts.lato(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: ThemeColor.get(context).primaryContent,
              ),
            ),
            GenericInput(title: "Tiêu đề", hint: "Nhập tiêu đề"),
            GenericInput(title: "Ghi chú", hint: "Nhập ghi chú"),
            GenericInput(
              title: "Ngày",
              hint: DateFormat("dd/MM/yyyy").format(_seletecDate),
              widget: IconButton(
                onPressed: () async {
                  await _getDateFromUser();
                },
                icon: Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: GenericInput(
                  title: "Giờ bắt đầu",
                  hint: DateFormat("hh:mm a", "vi").format(_startTime),
                  widget: IconButton(
                    onPressed: () async {
                      await _getTimeFromUser();
                    },
                    icon: Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey,
                    ),
                  ),
                )),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: GenericInput(
                  title: "Giờ kết thúc",
                  hint: DateFormat("hh:mm a", "vi").format(_endTime),
                  widget: IconButton(
                    onPressed: () async {
                      await _getTimeFromUser(isStartTime: false);
                    },
                    icon: Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ))
              ],
            ),
            GenericInput(
              title: "Báo thức",
              hint: "Báo trước $_selectedRemind phút",
              widget: DropdownButton(
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.grey,
                ),
                iconSize: 32,
                elevation: 4,
                style: GoogleFonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.get(context).primaryContent,
                ),
                underline: Container(),
                items: remindList.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text("$value"),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRemind = int.parse(value!);
                  });
                },
              ),
            ),
            GenericInput(
              title: "Lặp lại",
              hint: _selectedRepeat,
              widget: DropdownButton(
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.grey,
                ),
                iconSize: 32,
                elevation: 4,
                style: GoogleFonts.lato(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.get(context).primaryContent,
                ),
                underline: Container(),
                items: repeatList.map<DropdownMenuItem<String>>((value) {
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text("$value"),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRepeat = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 10));

    if (_pickerDate != null)
      setState(() {
        _seletecDate = _pickerDate;
      });
  }

  _getTimeFromUser({bool isStartTime = true}) async {
    TimeOfDay? pickedTime = await _showTimePicker();

    if (pickedTime == null) {
      // String _formatedTime = pickedTime!.format(context);
    } else if (isStartTime) {
      setState(() {
        _startTime = DateTime(0, 0, 0, pickedTime.hour, pickedTime.minute);
      });
    } else {
      setState(() {
        _endTime = DateTime(0, 0, 0, pickedTime.hour, pickedTime.minute);
      });
    }
  }

  _showTimePicker() async {
    return await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay.fromDateTime(_startTime),
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!),
    );
  }
}
