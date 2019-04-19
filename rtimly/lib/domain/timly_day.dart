import 'package:rtimly/domain/task.dart';

class TimlyDay {
  DateTime _day;
  int _index;
  List<Task> _dailyTasks;

  TimlyDay(DateTime day, int index, List<Task> tasks) {
    this._day = day;
    this._index = index;
    this._dailyTasks = tasks;
  }

  List<Task> getDailyTasks() {
    return this._dailyTasks;
  }

  DateTime getDay() {
    return this._day;
  }

  int getIndex() {
    return this._index;
  }
}