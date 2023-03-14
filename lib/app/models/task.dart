class Task {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Task({
    this.id,
    this.title,
    this.color,
    this.date,
    this.endTime,
    this.isCompleted,
    this.note,
    this.remind,
    this.repeat,
    this.startTime,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"],
        color: json["color"],
        date: json["date"],
        endTime: json["end_time"],
        isCompleted: json["is_completed"],
        note: json["note"],
        remind: json["remind"],
        repeat: json["repeat"],
        startTime: json["start_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "note": note,
        "date": date,
        "start_time": startTime,
        "end_time": endTime,
        "remind": remind,
        "repeat": repeat,
        "color": color,
        "is_completed": isCompleted,
      };
}
