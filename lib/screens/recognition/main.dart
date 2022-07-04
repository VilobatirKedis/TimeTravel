import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:time_travel/screens/explore/main.dart';
import 'package:time_travel/screens/map/map.dart';
import 'package:time_travel/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:time_travel/utils/monumentJSON.dart';

class Recognition extends StatefulWidget {
  final imagePath;
  final User user;
  const Recognition({Key? key, required dynamic this.imagePath, required User this.user}) : super(key: key);

  @override
  State<Recognition> createState() => _RecognitionState();
}

class _RecognitionState extends State<Recognition> {
  bool recognized = false;
  String id = "";
  MonumentsData? monumentRec;

  @override
  void initState() {
    imageRecognition().then((value) => {
      setState(() {
        id = value;
        recognized = true;

        for(MonumentsData monument in monuments) {
          print("ok");
          print(monument.id);
          print(id);
          if(monument.id.toString() == id) {
            print("ciao");
            monumentRec = monument;
            break;
          }
        }

        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => ExplorePage(monument: monumentRec!, mode: "current")
        ));
      })
    });
  }

  Future<String> imageRecognition() async {
    String token = await widget.user.getIdToken();

    var request = http.MultipartRequest(
      'POST', Uri.parse("https://time-travel-bp.herokuapp.com/monuments/predict")
    );

    Map<String,String> headers={
      "Authorization": token,
      "Content-type": "multipart/form-data"
    };

    request.files.add(
      http.MultipartFile(
        "photo",
        File(widget.imagePath).readAsBytes().asStream(),
        File(widget.imagePath).lengthSync(),
        filename: "img_" + widget.user.uid,
      )
    );

    request.headers.addAll(headers);

    var response = await request.send();
    String resStr = await response.stream.bytesToString();

    return resStr[6];
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: kMainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            recognized == false ? const CircularProgressIndicator(
              color: kSecondaryColor,
              backgroundColor: kMainColor,
              strokeWidth: 6,
            ) : const SizedBox(),
            SizedBox(height: 20,),
            recognized == false ? Text(
              "Scavo tra gli archivi...",
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 15.sp
              ),
            ) : Text(
              "Riconoscimento completato",
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 15.sp
              ),
            ),   
          ]
        ),
      ),
    );
  }
}