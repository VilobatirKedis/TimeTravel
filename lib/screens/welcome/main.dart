import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:time_travel/screens/authentication/sign_up.dart';
import 'package:time_travel/utils/constants.dart';

import '../authentication/sign_in.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: kMainColor,
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.25),
            child: Image.asset("assets/images/splash_screen/logo.png"),
          ),
          SignUpButton(),
          SignInButton()
        ]
      )
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.1),
      child: ElevatedButton(
        onPressed: () {
          //TODO: Add SignUp page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpPage()),
          );
        },
        child: Text("Sign Up", style: TextStyle(fontSize: size.width * 0.06, color: kMainColor, fontWeight: FontWeight.w800)),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            padding: EdgeInsets.fromLTRB(size.width * 0.35, size.height * 0.017, size.width * 0.35, size.height * 0.017),
          )
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.02),
      child: ElevatedButton(
        onPressed: () {
          //TODO: Add SignUp page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignInPage()),
          );
        },
        child: Text("Log In", style: TextStyle(fontSize: size.width * 0.04, color: Colors.black, fontWeight: FontWeight.w800)),
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            padding: EdgeInsets.fromLTRB(size.width * 0.15, size.height * 0.017, size.width * 0.15, size.height * 0.017),
          )
      ),
    );
  }
}
