import 'package:bucketlist/models/user.dart';
import 'package:bucketlist/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bucketlist/screens/LoginSignup/login.dart';
import 'package:bucketlist/screens/root.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Add this
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loggedIn = false;

  @override
  void initState() {
    super.initState();
    AuthService.onStartUp().then(
        (value) => value == "success" ? loggedIn = true : loggedIn = false);
  }

  Widget build(BuildContext context) {
    return StreamProvider<UserData>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
          title: 'Bucket List App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Color(0xFF3EBACE),
            accentColor: Color(0xFFD8ECF1),
            scaffoldBackgroundColor: Color(0xFFF3F5F7),
          ),
          home: Root()),
    );
  }
}
