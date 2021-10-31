import 'package:bucketlist/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:bucketlist/screens/LoginSignup/signup.dart';
import 'package:bucketlist/screens/root.dart';
import 'package:bucketlist/constants/colors.dart' as ColorConstants;
import 'package:bucketlist/widgets/widgets.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(),
      passwordController = TextEditingController();

  bool _isLoading = false;

  signIn() async {
    if (mounted)
      setState(() {
        _isLoading = true;
      });
    if (_formKey.currentState.validate()) {
      String res = await AuthService.signIn(
          emailController.text, passwordController.text);
      if (res == "success") {
        print("login success");
        if (mounted)
          setState(() {
            _isLoading = false;
          });
      } else {
        if (mounted)
          setState(() {
            _isLoading = false;
          });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(res.toString()),
          duration: Duration(seconds: 2),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Container(
                //padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                margin: EdgeInsets.fromLTRB(50, 50, 50, 30),
                child: Text("Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: TextFormField(
                  validator: (val) {
                    return val == "" ? 'Email' : null;
                  },
                  style: TextStyle(color: Colors.white),
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorConstants.loginSignupForm,
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: TextFormField(
                  obscureText: true,
                  validator: (val) {
                    return val == "" ? 'Password' : null;
                  },
                  style: TextStyle(color: Colors.white),
                  controller: passwordController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorConstants.loginSignupForm,
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  if (!_isLoading) signIn();
                  print("bruh");
                },
                child: ovalButton(
                    context: context,
                    label: "Login",
                    col: ColorConstants.loginSignupSubmit),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ",
                      style: TextStyle(fontSize: 15.5, color: Colors.white)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Signup()),
                      );
                    },
                    child: Text("Sign Up ",
                        style: TextStyle(
                            fontSize: 15.5,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline)),
                  )
                ],
              ),
              SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }
}
