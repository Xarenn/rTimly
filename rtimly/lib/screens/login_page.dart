import 'package:flutter/material.dart';
import 'package:rtimly/authentication/auth.dart';
import 'package:rtimly/authentication/auth_provider.dart';
import 'package:rtimly/util/authorization_util.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EmailFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Email can\'t be empty' : null;
  }
}

class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({this.onSignedIn, this.loader});

  final VoidCallback onSignedIn;
  final VoidCallback loader;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

enum FormType {
  login,
  register,
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  void validateAndSubmit() async {
    if (AuthUtil().validateAndSave(formKey)) {
      tryLogin();
    } else {
      // TODO show notification
    }
  }

  void tryLogin() async {
    try {
      var auth = AuthProvider.of(context).auth;
      if (_formType == FormType.login) {
        widget.loader();
        await AuthUtil().signIn(auth, _email, _password);
      } else if (_formType == FormType.register) {
        widget.loader();
        await AuthUtil().register(auth, _email, _password);
      }
      widget.onSignedIn();
    } catch (e) {
      print('Error: $e');
    }
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
        key: Key('email'),
        decoration: InputDecoration(labelText: 'Email'),
        validator: EmailFieldValidator.validate,
        onSaved: (value) => _email = value,
      ),
      TextFormField(
        key: Key('password'),
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: PasswordFieldValidator.validate,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        RaisedButton(
          key: Key('signIn'),
          child: Text('Login', style: TextStyle(fontSize: 20.0)),
          onPressed: () => validateAndSubmit(),
        ),
        FlatButton(
          child: Text('Create an account', style: TextStyle(fontSize: 20.0)),
          onPressed: moveToRegister,
        ),

        FlatButton(
          color: Color(0xFF486198),
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          onPressed: () {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                MdiIcons.facebook,
                color: Colors.white,
                size: 16.0,
              ),
              SizedBox(width: 8.0,),
              Text('Sign in with facebook', style: TextStyle(color: Colors.white),)
            ],
          ),
        ),

        FlatButton(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          onPressed: () {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                MdiIcons.google,
                size: 16.0,
              ),
              SizedBox(width: 8.0,),
              Text('Sign in with Google', style: TextStyle(color: Colors.grey),)
            ],
          ),
        ),
      ];
    } else {
      return [
        RaisedButton(
          child: Text('Create an account', style: TextStyle(fontSize: 20.0)),
          onPressed: validateAndSubmit,
        ),
        FlatButton(
          child:
              Text('Have an account? Login', style: TextStyle(fontSize: 20.0)),
          onPressed: moveToLogin,
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('rTimly login'),
        ),
        body: Container(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buildInputs() + buildSubmitButtons(),
              ),
            )));
  }
}
