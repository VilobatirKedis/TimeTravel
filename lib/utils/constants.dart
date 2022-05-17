import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

const kMainColor = Color.fromARGB(255, 23, 24, 31);
const kSecondaryColor = Color.fromARGB(255, 65, 72, 237);
const kBorderColor = Color.fromARGB(255, 45, 45, 59);

void setStatusBarColor(color) async {
  await FlutterStatusbarcolor.setStatusBarColor(color);
}

Future<void> customDialog(context, message, title) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[Text(message)],
        ),
      ),
      backgroundColor: kMainColor,
      titleTextStyle: GoogleFonts.montserrat(
          textStyle: Theme.of(context).textTheme.headline4,
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white),
      contentTextStyle: GoogleFonts.montserrat(
          textStyle: Theme.of(context).textTheme.headline4,
          fontSize: 10.sp,
          fontWeight: FontWeight.w200,
          color: Colors.white),
    )
  );
}
