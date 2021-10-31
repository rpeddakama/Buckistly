import 'dart:io';

import 'package:bucketlist/models/user.dart';
import 'package:bucketlist/services/auth.dart';
import 'package:bucketlist/services/databse.dart';
import 'package:bucketlist/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserData curUser;
  String newUid;
  signOut() {
    AuthService.signOut();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    curUser = await DataBase().getUserInfo(newUid);
  }

  @override
  Widget build(BuildContext context) {
    UserData tempU = Provider.of(context);
    setState(() {
      newUid = tempU.uid;
    });
    return Scaffold(
      // appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(height: 48),
          ProfileWidget(
            // imagePath: user.imagePath,
            onClicked: () async {},
          ),
          SizedBox(height: 24),
          buildName(),
          SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          // SizedBox(height: 24),
          // NumbersWidget(),
          // SizedBox(height: 48),
          // buildAbout(context),
        ],
      ),
    );
  }

  Widget buildName() {
    return Column(
      children: [
        Text(
          // curUser.name,
          "Rishi Peddakama",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
        ),
        const SizedBox(height: 4),
        Text(
          "rishipeddakama@gmail.com",
          // curUser.email,
          style: TextStyle(color: Colors.grey, fontSize: 20),
        )
      ],
    );
  }

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Sign Out',
        onClicked: () {
          signOut();
        },
      );

  Widget buildAbout(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              "user about",
              // user.about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
