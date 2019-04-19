import 'package:date_utils/date_utils.dart';
import 'package:rtimly/domain/task.dart';
import 'package:rtimly/domain/timly_day.dart';

class CalendarData {
  static const int DAYS_BEFORE = 6;
  static const int DAYS_AFTER = 7;

  List<TimlyDay> getDaysFromTo(DateTime dateTimeFrom, DateTime dateTimeTo) {}

  List<TimlyDay> getDaysFromNow() {
    Struct struct = prepareTasks(DateTime.now());
    List<Task> tasks = struct.tasks;
    List<TimlyDay> days = [];
    for (int i = 0; i < DAYS_BEFORE+DAYS_AFTER; ++i) {
        days.add(new TimlyDay(struct.days[i], i,
            tasks.where((task) => task.getDay() == struct.days[i]).toList()));
    }
    return days;
  }

  Struct prepareTasks(DateTime dateTime) {
    List<Task> tasks = [];
    List<DateTime> days = [];
    if (dateTime.day - DAYS_BEFORE < 0) {
      print("Tasks in " +
          dateTime.month.toString() +
          " and " +
          (dateTime.month - 1).toString());
      DateTime dateAfter =
          new DateTime(DateTime.now().year, DateTime.now().month - 1);
      for (int d = 0; d < -(dateTime.day - DAYS_BEFORE); ++d) {
        days.add(new DateTime(DateTime.now().year, DateTime.now().month - 1,
            Utils.lastDayOfMonth(dateAfter).day - d));
      }
    } else {
      for (int d = DateTime.now().day-1; d > DateTime.now().day-DAYS_BEFORE; --d) {
        print(d);
        days.add(new DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day - d));
      }
    }

    for (int d = 0; d < DAYS_AFTER+1; ++d) {
      days.add(new DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + d));
    }
    print(days);
    print(days.length);
    for (int i = 0; i < DAYS_AFTER + DAYS_BEFORE; ++i) {
      tasks.add(new Task(
          dateTime: days[i],
          title: "Task #" + (i).toString(),
          description: "Lubie taski #" + i.toString()));
      if(i % 2 == 0) {
        tasks.add(new Task(
            dateTime: days[i],
            title: "Task #" + (i).toString(),
            description: "Lubie taski #" + i.toString()));
      }
    }
    Struct struct = new Struct(tasks, days);
    return struct;
  }
}

class Struct {
  List<Task> tasks;
  List<DateTime> days;

  Struct(List<Task> tasks, List<DateTime> days) {
    this.tasks = tasks;
    this.days = days;
  }
}
