import 'dart:async';

import 'package:date_utils/date_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rtimly/domain/profile.dart';
import 'package:rtimly/domain/settings/settings.dart';
import 'package:rtimly/domain/task.dart';
import 'package:rtimly/domain/timly_day.dart';
import 'package:rtimly/screens/calendar/builder/calendar_data.dart';
import 'package:rtimly/screens/home/backdrop.dart';

class CalendarView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TaskViewState();
}

class _TaskViewState extends State<CalendarView> {
  int _id;
  int _currentDay = DateTime.now().day;

  List<TimlyDay> _days = [];

  final VoidCallback onSignedOut;

  _TaskViewState({this.onSignedOut});

  TimlyDay findDayByIndex(int ind) {
    return _days[ind];
  }

  String getDayFromIndex(int ind) {
    return _days[ind].getDay().day.toString();
  }

  List<Task> getTasksFromDay(TimlyDay timlyDay) {
    return timlyDay.getDailyTasks();
  }

  @override
  void initState() {
    _days = CalendarData().getDaysFromNow();
    if (_days.isEmpty) {
      _days = CalendarData().getDaysFromNow();
    }
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Task> values = snapshot.data;
    return new ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return new Column(
          children: <Widget>[
            new ListTile(
                title: new Text(values[index].getTitle()),
                subtitle: new Text("Description"),
                onTap: () => print(values[index].getTitle()),
                leading: Container(
                  child: Icon(Icons.assignment_late, color: Colors.blue),
                ),
                trailing: Icon(Icons.keyboard_arrow_right,
                    color: Colors.blue, size: 35.0)),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(children: <Widget>[
      SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 25.0),
            height: MediaQuery.of(context).size.height - 25,
            width: MediaQuery.of(context).size.width - 130,
            child: FutureBuilder(
                future: _getTasks(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return new Text("Reload");
                    case ConnectionState.waiting:
                      return new Text("Awaiting result");
                    default:
                      if (snapshot.hasError) {
                        return new Text("Error: ${snapshot.error}");
                      } else {
                        return this.createListView(context, snapshot);
                      }
                  }
                })),
      ),
      SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
        child: Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0),
            height: MediaQuery.of(context).size.height-25,
            width: 120.0,
            child: new ListView(
                children: new List.generate(_days.length, (int index) {
              return new ListTile(
                  title: new Text(this.getDayFromIndex(index)),
                  subtitle: Text('Day'),
                  leading: Icon(
                    Icons.calendar_today,
                    color: Colors.blue[300],
                    size: 30.0,
                  ),
                  onTap: () {
                    setState(() {
                      _id = index;
                      _currentDay = findDayByIndex(index).getDay().day;
                    });
                  });
            }))),
      ),
    ]));
  }

  Future<List<Task>> _getTasks() async {
    List<Task> empty = [];
    List<TimlyDay> dayWith = _days
        .where((day) => (day
                .getDailyTasks()
                .where((task) => task.getDay().day == _currentDay))
            .isNotEmpty)
        .toList();
    return dayWith.isNotEmpty ? dayWith[0].getDailyTasks() : empty;
  }
}
