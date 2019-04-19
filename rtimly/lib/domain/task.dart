class Task {
  String _title, _description;
  DateTime _day;

  Task({dateTime: DateTime, title: String, description: String}) {
    this._title = title;
    this._day = dateTime;
    this._description = description;
  }

  DateTime getDay() {
    return this._day;
  }

  String getTitle() {
    return this._title;
  }

  String getDescription() {
    return this._description;
  }

}