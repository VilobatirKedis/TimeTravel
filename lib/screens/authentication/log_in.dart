import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:time_travel/utils/auth_service.dart';
import 'package:time_travel/utils/form_validator.dart';
import 'package:time_travel/utils/constants.dart';
import 'package:time_travel/screens/home_page/main.dart';

class LogInPage extends StatefulWidget {
  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //final firebaseUser = context.watch<User?>();
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          setStatusBarColor(kMainColor);
          return SafeArea(
            child: Scaffold(
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
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.05),
                      child: SizedBox(
                          width: size.width * 0.95,
                          child: ThirdPartyLoginButton(
                              size: size, service: "Google")),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.02),
                      child: SizedBox(
                          width: size.width * 0.95,
                          child: ThirdPartyLoginButton(
                              size: size, service: "Facebook")),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.04),
                      child: Text(
                        "Or",
                        style: GoogleFonts.montserrat(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.w200,
                            color: Colors.white),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.05),
                          child: GeneralTextField(
                              size: size,
                              controller: emailController,
                              label: "E-mail",
                              icon: Icons.email_rounded),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GeneralTextField(
                              size: size,
                              controller: passwordController,
                              label: "Password",
                              icon: Icons.key_rounded),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.2),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            User? user;
                            try {
                              user = await AuthenticationService.signInUsingEmailPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                            } catch (e) {
                              credentialsErrorDialog(context, "Check your credentials and try again", size);
                            }

                            if (user != null) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => HomePage(user: user!)),
                              );
                            }
                          }
                        },
                        child: Text(
                          "Log In",
                          style: GoogleFonts.montserrat(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.40,
                              vertical: size.height * 0.016),
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
                          "Don't have an account?",
                          style: GoogleFonts.montserrat(
                              textStyle: Theme.of(context).textTheme.headline4,
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.w200,
                              color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Sign Up",
                            style: GoogleFonts.montserrat(
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                fontSize: size.width * 0.04,
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
        return const Center(child: CircularProgressIndicator());
      }
    );
  }
}

Future<void> credentialsErrorDialog(context, message, size) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
            title: const Text('Error'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(message)
                ],
              ),
            ),
            backgroundColor: kMainColor,
            titleTextStyle: GoogleFonts.montserrat(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.w700,
              color: Colors.white
            ),
            contentTextStyle: GoogleFonts.montserrat(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.w200,
              color: Colors.white
            ),
          ));
}

class GeneralTextField extends StatelessWidget {
  const GeneralTextField(
      {Key? key,
      required this.size,
      required this.controller,
      required this.label,
      required this.icon})
      : super(key: key);

  final Size size;
  final TextEditingController controller;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      /*decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            offset: Offset(0, 3),
            blurRadius: 2,
            spreadRadius: 2
          )
        ]
      ),*/
      child: SizedBox(
        width: size.width * 0.95,
        child: TextFormField(
          validator: (value) {
            if (label == "Password") {
              Validator.validatePassword(password: value!);
            } else {
              Validator.validateEmail(email: value!);
            }
          },
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
                color: Colors.white),
            floatingLabelStyle: GoogleFonts.montserrat(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: size.width * 0.04,
                fontWeight: FontWeight.w200,
                color: Colors.white),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(width: 3, color: kBorderColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(19),
                borderSide: const BorderSide(width: 3, color: kSecondaryColor)),
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: (value) {
            // do something
          },
        ),
      ),
    );
  }
}

class ThirdPartyLoginButton extends StatelessWidget {
  const ThirdPartyLoginButton(
      {Key? key, required this.size, required this.service})
      : super(key: key);

  final Size size;
  final String service;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        if (service == "Google") {
          try {
            await AuthenticationService.signInWithGoogle().then((user) => {
              if(user != null) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => HomePage(user: user)
                  )
                )
              }
            
            });
          } catch (e) {
            credentialsErrorDialog(context, "Error with Google log in.", size);
          }
        }
      },
      icon: Image.asset(
        "assets/icons/${service.toLowerCase()}.png",
        scale: 15,
      ),
      label: Text(
        "Continue with $service",
        style:
            TextStyle(fontWeight: FontWeight.w200, fontSize: size.width * 0.05),
      ),
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.015),
          primary: kMainColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.elliptical(15, 15))),
          side: const BorderSide(
            width: 3,
            color: kBorderColor,
          )),
    );
  }
}
