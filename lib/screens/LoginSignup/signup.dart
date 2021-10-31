import 'package:bucketlist/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:bucketlist/screens/LoginSignup/login.dart';
import 'package:bucketlist/screens/root.dart';
import 'package:bucketlist/widgets/widgets.dart';
import 'package:bucketlist/constants/colors.dart' as ColorConstants;

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  final nameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController();

  signup() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      String res = await AuthService.signUp(
          nameController.text, emailController.text, passwordController.text);
      if (res == "success") {
        setState(() => _isLoading = false);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Root()));
      } else {
        print("alert yo");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(res)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
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
                child: Text("Sign Up",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold)),
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: TextFormField(
                  validator: (val) {
                    return val == "" ? 'Name' : null;
                  },
                  style: TextStyle(color: Colors.white),
                  controller: nameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorConstants.loginSignupForm,
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: "Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
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
              //RoundedInput(hintText: "Email"),
              //RoundedInput(hintText: "Password"),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () => signup(),
                child: ovalButton(
                    context: context,
                    label: "Sign Up",
                    col: ColorConstants.loginSignupSubmit),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? ",
                      style: TextStyle(fontSize: 15.5, color: Colors.white)),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    ),
                    child: Text("Login ",
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
