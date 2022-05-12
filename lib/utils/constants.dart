import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

const kMainColor = Color.fromARGB(255, 23, 24, 31);
const kSecondaryColor = Color.fromARGB(255, 65, 72, 237);
const kBorderColor = Color.fromARGB(255, 45, 45, 59);

void setStatusBarColor(color) async {
  await FlutterStatusbarcolor.setStatusBarColor(color);
}
