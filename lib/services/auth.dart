import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bucketlist/models/user.dart';
import 'package:bucketlist/services/databse.dart';

class AuthService {
  static UserData curUser = new UserData();
  static FirebaseAuth auth = FirebaseAuth.instance;
  User bob;

  UserData userFromFirebaseUser(User user) {
    return user != null ? UserData(uid: user.uid) : null;
  }

  Stream<UserData> get user {
    return auth
        .authStateChanges()
        .map((User user) => userFromFirebaseUser(user));
  }

  static Future<String> onStartUp() async {
    String ret = "error";
    try {
      ret = "success";
    } catch (e) {
      print(e);
    }
    return ret;
  }

  static Future signIn(String email, String password) async {
    try {
      UserCredential res = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      curUser = await DataBase().getUserInfo(res.user.uid);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future signUp(String name, String email, String password) async {
    UserData _user = new UserData();
    try {
      UserCredential res = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      _user.name = name;
      _user.email = res.user.email;
      _user.uid = res.user.uid;
      DataBase().createUser(_user);

      return true;
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future signOut() async {
    try {
      await auth.signOut();
      curUser = new UserData();
    } catch (e) {
      print(e);
    }
  }
}
