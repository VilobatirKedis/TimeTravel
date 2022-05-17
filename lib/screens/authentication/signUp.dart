import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:time_travel/screens/home_page/main.dart';
import 'package:time_travel/utils/authService.dart';

import '../../utils/constants.dart';
import 'logIn.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: kMainColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Text(
                    "Sign Up.",
                    style: GoogleFonts.montserrat(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ),
              
              Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: GeneralTextField(
                      size: size,
                      controller: usernameController,
                      label: "Username",
                      icon: Icons.person_rounded
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: GeneralTextField(
                      size: size,
                      controller: emailController,
                      label: "E-mail",
                      icon: Icons.email_rounded
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: GeneralTextField(
                      size: size,
                      controller: passwordController,
                      label: "Password",
                      icon: Icons.key_rounded
                    ),
                  ),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 7.h),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      User? user;
                      try {
                        user = await AuthenticationService
                            .registerUsingEmailPassword(
                          username: usernameController.text.trim(),
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                      } catch (e) {
                        customDialog(context, e.toString(), "Error");
                      }

                      if (user != null) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomePage(user: user!)),
                        );
                      }
                    }
                  },
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.montserrat(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 40.w,
                        vertical: 2.h),
                    primary: kSecondaryColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(15, 15))),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: GoogleFonts.montserrat(
                        textStyle: Theme.of(context).textTheme.headline4,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w200,
                        color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => LogInPage()));
                    },
                    child: Text(
                      "Log In",
                      style: GoogleFonts.montserrat(
                          textStyle:
                              Theme.of(context).textTheme.headline4,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: kSecondaryColor),
                    ),
                    style: TextButton.styleFrom(primary: kSecondaryColor),
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
