import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:provider/provider.dart';
import 'package:time_travel/utils/auth_service.dart';

import '../../utils/constants.dart';
import '../home_page/main.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return HomePage();
    } else {
      return SafeArea(
          child: Form(
              emailController: emailController,
              passwordController: passwordController));
    }
  }
}

class Form extends StatelessWidget {
  const Form({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(kMainColor);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kMainColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.width * 0.4),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email_rounded),
                labelText: 'Password',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 2
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 2
                  )
                ),
              ),
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                // do something
              },
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.email_rounded),
              labelText: 'Password',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2
                )
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2
                )
              ),
            ),
            style: TextStyle(color: Colors.white),
            onChanged: (value) {
              // do something
            },
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthenticationService>().signIn(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
            },
            child: Text("Sign in"),
          )
        ],
      ),
    );
  }
}
