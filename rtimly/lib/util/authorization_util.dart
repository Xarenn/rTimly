import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rtimly/authentication/auth.dart';

class AuthUtil {
  bool validateAndSave(GlobalKey<FormState> formKey) {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> signIn(BaseAuth auth, String email, String password) async {
    String userId = await auth.signInWithEmailAndPassword(email, password);
    print('Signed in: $userId');
  }
  Future<void> register(BaseAuth auth, String email, String password) async {
    String userId = await auth.createUserWithEmailAndPassword(email, password);
    print('Registered user: $userId');
  }
}
