import 'package:bucketlist/CreateBucketlistForm/form.dart';
import 'package:flutter/material.dart';
import 'package:bucketlist/constants/colors.dart' as ColorConstants;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget bucketlistCard(BuildContext context) {
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
            leading: Icon(Icons.flight),
            title: Text(
              "from here to there",
              style: TextStyle(fontSize: 30),
            ),
            subtitle: Text(
              'Desired price of 1k',
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
                print("deleted");
              },
            ),
            SizedBox(width: 8),
          ],
        ),
      ],
    ));
  }

  Widget build(BuildContext context) {
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
          padding: EdgeInsets.symmetric(vertical: 30.0),
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
              child: Column(
                children: [bucketlistCard(context), bucketlistCard(context)],
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
