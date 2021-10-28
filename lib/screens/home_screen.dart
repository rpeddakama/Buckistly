import 'package:bucketlist/CreateBucketlistForm/form.dart';
import 'package:bucketlist/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bucketlist/constants/colors.dart' as ColorConstants;
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget bucketlistCard(String from, String to, int price, String id) {
    UserData curUser = Provider.of(context);
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
            leading: Icon(Icons.flight),
            title: Text(
              'From $from to $to',
              style: TextStyle(fontSize: 30),
            ),
            subtitle: Text(
              'Desired price: \$$price',
              style: TextStyle(fontSize: 20),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              child: Text(
                'EDIT',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                print("going to edit page");
              },
            ),
            TextButton(
                child: Text(
                  'DELETE',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(curUser.uid)
                      .collection("flights")
                      .doc(id)
                      .delete();
                }),
            SizedBox(width: 8),
          ],
        ),
      ],
    ));
  }

  Widget build(BuildContext context) {
    UserData curUser = Provider.of(context);
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: ColorConstants.createBucketlistItem,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BucketlistItemForm()));
          }),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                'My Bucket List',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(curUser.uid)
                    .collection("flights")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  } else
                    snapshot.data.docs.forEach((element) {
                      print(element.data());
                    });
                  return ListView(
                    shrinkWrap: true,
                    children: snapshot.data.docs.map((document) {
                      return bucketlistCard(document["from"], document["to"],
                          document["price"], document.id);
                      // return Text("BRUH");
                    }).toList(),
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
