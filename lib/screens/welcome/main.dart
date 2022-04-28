import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_travel/utils/constants.dart';

class Welcome extends StatelessWidget {
  const Welcome({ Key? key }) : super(key: key);

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return const SafeArea(
      top: false,
      child: Scaffold(
        primary: true,
        backgroundColor: kMainColor,
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RichText(
      textAlign: TextAlign.center,
      text: /*TextSpan(text: "Hello")*/TextSpan(
        text: "Your place to",
        style: TextStyle(
          fontSize: size.width * 0.15,
          fontWeight: FontWeight.w700,
          color: kMainColor
        ),
        children: <TextSpan>[
          TextSpan(
            text: " share ",
            style: TextStyle(
              fontSize: size.width * 0.15,
              fontWeight: FontWeight.w700,
              color: kMainColor
            )
          ),
          TextSpan(
            text: "books"
          ),
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

    return ElevatedButton.icon(
      onPressed: () {
        //TODO: Add SignUp page
        //Navigator.push(context, RouteManager.leftToRight(() {return SignUp();}));
      },
      label: Icon(
        Icons.arrow_right_alt_rounded,
        size: size.width * 0.07
      ),
      icon: Text(
        "Sign Up",
        style: TextStyle(
          fontSize: size.width * 0.05
        )
      ), 
      style: ElevatedButton.styleFrom(
        primary: kMainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        padding: kButtonInset
      )
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


    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {return Scaffold();}));
      }, 
      child: Text(
        "Sign In",
        style: TextStyle(
          fontSize: size.width * 0.04
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: kMainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        padding: kSecondaryButtonInset
      )
    );
  }
}