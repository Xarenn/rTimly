import 'package:flutter/material.dart';
import 'package:rtimly/authentication/auth_provider.dart';
import 'package:rtimly/screens/calendar/calendar_view.dart';
import 'package:rtimly/screens/home/backdrop.dart';
import 'package:rtimly/screens/root_page.dart';

class HomePage extends StatefulWidget {
  HomePage({this.onSignedOut});

  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => _HomePageState(onSignedOut: onSignedOut);
}

class _HomePageState extends State<HomePage> {
  final VoidCallback onSignedOut;

  _HomePageState({this.onSignedOut});

  Widget _currentWidget = HomeView();

  @override
  Widget build(BuildContext context) {
    return Backdrop(
      frontLayer: _currentWidget,
      backLayer: buildMenu(),
    );
  }

  void _signOut(BuildContext context) async {
    try {
      var auth = AuthProvider.of(context).auth;
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  Widget buildMenu() {
    return Center(
      child: Container(
        color: Colors.teal,
        child: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('Home'),
                onPressed: () {
                  setState(() {
                    setState(() {
                      _currentWidget = HomeView();

                    });
                  });
                },
              ),
              RaisedButton(
                child: Text('Calendar'),
                onPressed: () {
                  setState(() {
                    _currentWidget = CalendarView();
                  });
                },
              ),
              RaisedButton(
                child: Text('Logout'),
                onPressed: () {
                  _signOut(context);
                },
              ),
            ],
          ),
//          child: Center(
//            child: RaisedButton(
//              child: Text('Logout'),
//              onPressed: () {
//                _signOut(context);
//              },
//            ),
//          ),
        ),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Home'));
  }
}
