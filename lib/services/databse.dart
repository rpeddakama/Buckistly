
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:bucketlist/models/group.dart';
import 'package:bucketlist/models/user.dart';

class DataBase {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Future<UserData> getUserInfo(String uid) async {
  //   UserData res = new UserData();
  //   try {
  //     DocumentSnapshot snapshot =
  //         await firestore.collection("users").doc(uid).get();
  //     Map<String, dynamic> data = snapshot.data();
  //     res.uid = uid;
  //     res.name = data['name'];
  //     res.email = data['email'];
  //     res.accountCreated = data['accountCreated'];
  //     res.groupList = data['groupList'];
  //     return res;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

}