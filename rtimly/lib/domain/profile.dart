import 'package:flutter/material.dart';
import 'package:rtimly/domain/task.dart';
import 'package:rtimly/domain/settings/settings.dart';

class Profile {

  String userName;
  String login;
  List<Task> taskList;
  Settings settings;

  Profile({username: String, login: String, taskList: List, settings: Settings }) {
    this.settings = settings;
    this.userName = username;
    this.taskList = taskList;
    this.login = login;
  }

}
