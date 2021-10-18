import 'package:bucketlist/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            //padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            padding: EdgeInsets.fromLTRB(50, 50, 50, 30),
            child: Text("My Profile",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold)),
          ),
          ProfileWidget(
            imagePath: "yo",
            onClicked: () async {},
          ),
          SizedBox(height: 24),
          SizedBox(height: 24),
          SizedBox(height: 24),
          // NumbersWidget(),
          Text("COMING SOON",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Upgrade To PRO',
        onClicked: () {},
      );
}
