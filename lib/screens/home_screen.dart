import 'package:bucketlist/CreateBucketlistForm/form.dart';
import 'package:bucketlist/constants/localData.dart';
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
  Widget toFromText(String value) {
    return Text(
      value,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget locationText(String value) {
    return Text(
      value,
      style: TextStyle(fontSize: 17, color: Colors.black),
    );
  }

  Widget bucketlistCard(String from, String to, int price, String id) {
    UserData curUser = Provider.of(context);
    return Card(
        elevation: 5,
        color: Color(0xffdeebff),
        borderOnForeground: false,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
                leading: Icon(Icons.flight),
                title: Column(
                  children: [
                    SizedBox(height: 5),
                    Row(children: [
                      toFromText('From: '),
                      locationText(from.trim())
                    ]),
                    SizedBox(height: 2),
                    Row(children: [
                      toFromText('To: '),
                      locationText(to.trim())
                    ]),
                    SizedBox(height: 15)
                  ],
                ),
                subtitle: Text(
                  'Desired price: \$$price',
                  style: TextStyle(fontSize: 20),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                // TextButton(
                //   child: Text(
                //     'EDIT',
                //     style: TextStyle(fontSize: 20),
                //   ),
                //   onPressed: () {
                //     print("going to edit page");
                //   },
                // ),
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

  int _index = 0;
  var pictures = ['kayaklogo.png', 'trivagologo.png', 'airbnblogo.jpg'];

  Widget build(BuildContext context) {
    UserData curUser = Provider.of(context);
    print("HOME NAME");
    print(curUser.email);
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
            SizedBox(height: 48),
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                'My Bucket List',
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 15),
            Center(
              child: SizedBox(
                height: 150, // card height
                child: PageView.builder(
                  itemCount: 3,
                  controller: PageController(viewportFraction: 0.7),
                  onPageChanged: (int index) => setState(() => _index = index),
                  itemBuilder: (_, i) {
                    return Transform.scale(
                      scale: i == _index ? 1 : 0.9,
                      child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Image(
                            image: AssetImage('assets/images/${pictures[i]}'),
                            fit: BoxFit.fill,
                          )),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 15),
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
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
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
      // bottomNavigationBar: ,
    );
  }
}
