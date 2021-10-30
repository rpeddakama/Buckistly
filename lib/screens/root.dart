import 'package:bucketlist/models/user.dart';
import 'package:bucketlist/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:bucketlist/screens/LoginSignup/login.dart';
import 'package:bucketlist/screens/home_screen.dart';
import 'package:bucketlist/screens/profile.dart';
import 'package:bucketlist/screens/search_screen.dart';
import 'package:provider/provider.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  int _currentTab = 0;

  final tabs = [SearchScreen(), Home(), Profile()];

  @override
  Widget build(BuildContext context) {
    UserData user = Provider.of(context);
    if (user == null) return Login();
    return Scaffold(
      body: tabs[_currentTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (int value) {
          setState(() {
            _currentTab = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.airplane_ticket,
              size: 30.0,
            ),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30.0,
            ),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30.0),
            title: SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
