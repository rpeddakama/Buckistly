import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String uid, email, name;
  Timestamp accountCreated;

  UserData({this.uid, this.email, this.name, this.accountCreated});
}
