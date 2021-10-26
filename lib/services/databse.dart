import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:bucketlist/models/group.dart';
import 'package:bucketlist/models/user.dart';

class DataBase {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> createUser(UserData user) async {
    try {
      await firestore.collection("users").doc(user.uid).set({
        'name': user.name,
        'email': user.email,
        'accountCreated': Timestamp.now()
      });
      return "success";
    } catch (e) {
      print(e);
    }
    return "error";
  }

  Future<UserData> getUserInfo(String uid) async {
    UserData res = new UserData();
    try {
      DocumentSnapshot snapshot =
          await firestore.collection("users").doc(uid).get();
      Map<String, dynamic> data = snapshot.data();
      res.uid = uid;
      res.name = data['name'];
      res.email = data['email'];
      res.accountCreated = data['accountCreated'];
      return res;
    } catch (e) {
      print(e);
    }
  }

  Future<String> createListItem(String uid) async {
    UserData res = new UserData();
    try {
      await firestore
          .collection("users")
          .doc(uid)
          .collection("flights")
          .add({'from': 'LAX', 'to': 'JFK', 'price': 2000});
      return "success";
    } catch (e) {
      print(e);
      return "error";
    }
  }

  Future<List<dynamic>> getListItems(String uid) async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection("users")
          .doc(uid)
          .collection("flights")
          .get();

      List<DocumentSnapshot> list = snapshot.docs;
      List<dynamic> res = [];
      list.forEach((element) {
        res.add(element.data());
      });

      // print(res.length);
      return res;
    } catch (e) {
      print(e);
    }
  }
}
