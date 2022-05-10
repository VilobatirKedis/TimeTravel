import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
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
          passwordController: passwordController
        )
      );
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
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: size.height * 0.12),
                child: Text(
                  "Log In.",
                  style: GoogleFonts.montserrat(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: size.width * 0.1,
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.05),
              child: SizedBox(width: size.width * 0.95,child: ThirdPartyLoginButton(size: size, service: "Google")),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.02),
              child: SizedBox(width: size.width * 0.95,child: ThirdPartyLoginButton(size: size, service: "Facebook")),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.03),
              child: Text(
                "Or",
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context).textTheme.headline4,
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.w200,
                  color: Colors.white
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.04),
              child: GeneralTextField(size: size, controller: emailController, label: "E-mail", icon: Icons.email_rounded),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.02),
              child: GeneralTextField(size: size, controller: passwordController, label: "Password", icon: Icons.key_rounded),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.2),
              child: ElevatedButton(
                onPressed: () {
                  try {
                    final result = context.read<AuthenticationService>().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                  } catch (error) {
                    print("ciao");
                    credentialsErrorDialog(context, error.toString());
                  }
                },
                child: Text(
                  "Log In",
                  style: GoogleFonts.montserrat(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.40, vertical: size.height * 0.016),
                  primary: kSecondaryColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.elliptical(15, 15))
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: GoogleFonts.montserrat(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w200,
                    color: Colors.white
                  ),
                ),
                TextButton(
                  onPressed: () {}, 
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.montserrat(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.w600,
                      color: kSecondaryColor
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: kSecondaryColor
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<void> credentialsErrorDialog(context, message) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Error with Log In'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(message),
            Text('Check your credentials and try again'),
          ],
        ),
      ),
    )
  );
}

class GeneralTextField extends StatelessWidget {
  const GeneralTextField({
    Key? key,
    required this.size,
    required this.controller,
    required this.label,
    required this.icon
  }) : super(key: key);

  final Size size;
  final TextEditingController controller;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.95,
      child: TextField(
        obscureText: label == "Password" ? true : false,
        controller: controller,
        cursorColor: kSecondaryColor,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white),
          labelText: label,
          labelStyle: GoogleFonts.montserrat(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: size.width * 0.04,
            fontWeight: FontWeight.w200,
            color: Colors.white
          ),
          floatingLabelStyle: GoogleFonts.montserrat(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: size.width * 0.04,
            fontWeight: FontWeight.w200,
            color: Colors.white
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(width: 3, color: kBorderColor)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(19),
            borderSide: const BorderSide(width: 3, color: kSecondaryColor)
          ),
        ),
        style: const TextStyle(color: Colors.white),
        onChanged: (value) {
          // do something
        },
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
        padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
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
