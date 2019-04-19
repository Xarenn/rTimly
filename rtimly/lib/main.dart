import 'package:flutter/material.dart';
import 'package:rtimly/authentication/auth.dart';
import 'package:rtimly/authentication/auth_provider.dart';
import 'package:rtimly/screens/root_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
        auth: Auth(),
        child: new MaterialApp(
          title: 'rTimly',
          theme: new ThemeData(
            primarySwatch: Colors.teal,
          ),
          home: new RootPage(),
        ));
  }
}
