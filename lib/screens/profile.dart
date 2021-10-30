import 'package:bucketlist/models/user.dart';
import 'package:bucketlist/screens/LoginSignup/login.dart';
import 'package:bucketlist/services/auth.dart';
import 'package:bucketlist/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  signOut() {
    AuthService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            // imagePath: user.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(context),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 48),
          buildAbout(context),
        ],
      ),
    );
  }

  Widget buildName(BuildContext context) {
    // UserData curUser = Provider.of(context, listen: false);
    UserData curUser = new UserData();
    curUser.name = "test";
    curUser.email = "testemail";
    return Column(
      children: [
        Text(
          // "bruh",
          curUser.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          // "bruh",
          curUser.email,
          style: TextStyle(color: Colors.grey),
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
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
