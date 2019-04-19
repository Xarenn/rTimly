import 'dart:async';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);

  Future<String> createUserWithEmailAndPassword(String email, String password);

  Future<String> currentUser();

  Future<void> signOut();
}

class Auth implements BaseAuth {
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return new Future.delayed(const Duration(seconds: 2), () => "login wait 1");
  }

  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    return new Future.delayed(const Duration(seconds: 2), () => "register wait 1");
  }

  Future<String> currentUser() async {
    return "";
  }

  Future<void> signOut() async {}
}
