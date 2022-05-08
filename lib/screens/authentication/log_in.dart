import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:provider/provider.dart';
import 'package:time_travel/utils/auth_service.dart';

import '../../utils/constants.dart';
import '../home_page/main.dart';

class LogInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return HomePage();
    } else {
      return SafeArea(
          child: Body(
              emailController: emailController,
              passwordController: passwordController));
    }
  }
}

class Body extends StatelessWidget {
  const Body({
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
            padding: EdgeInsets.only(top: size.height * 0.1),
            child: Text(
              "Log In.",
              style: TextStyle(
                fontSize: size.width * 0.1,
                color: Colors.white,
                fontWeight: FontWeight.w900
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.05),
            child: ThirdPartyLoginButton(size: size * 1.075, service: "Google"),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.02),
            child: ThirdPartyLoginButton(size: size, service: "Facebook"),
          ),
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.05),
            child: Text(
              "Or",
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.w200
              ),
            ),
          ),
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

class ThirdPartyLoginButton extends StatelessWidget {
  const ThirdPartyLoginButton({
    Key? key,
    required this.size,
    required this.service
  }) : super(key: key);

  final Size size;
  final String service;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Image.asset(
        "assets/icons/${service.toLowerCase()}.png",
        scale: 15,
      ),
      label: Text(
        "Continue with $service",
        style: TextStyle(
          fontWeight: FontWeight.w200,
          fontSize: size.width * 0.05
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.16, vertical: size.height * 0.015),
        primary: kMainColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.elliptical(15, 15))
        ),
        side: const BorderSide(
          width: 3,
          color: kBorderColor,
        )
      ),
    );
  }
}
