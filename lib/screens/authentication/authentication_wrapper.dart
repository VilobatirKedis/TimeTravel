import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_travel/screens/authentication/sign_in.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    
    // ignore: unnecessary_null_comparison
    if(firebaseUser != null) {
      return const Text("SEI LOGGATO");
    }

    return SafeArea(child: SignInPage());
  }
}