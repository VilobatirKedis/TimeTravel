import 'dart:io';

import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:time_travel/screens/recognition/main.dart';
import 'package:time_travel/utils/constants.dart';
import 'package:image/image.dart' as img;

class PhotoPreview extends StatelessWidget {
  final String imagePath;
  final User user;

  const PhotoPreview({Key? key, required this.imagePath, required User this.user})
      : super(key: key);

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  Uint8List imageToByteListFloat32(
    img.Image image, int width, int height, double mean, double std) {
    var convertedBytes = Float32List(1 * width * height * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < height; i++) {
      for (var j = 0; j < width; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Column(
        children: [
          Image.file(File(imagePath)),
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              "Vuoi usare questo scatto?",
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  PhotoButton(label: "NO", callback: () {
                    Navigator.pop(context);
                  }),
                  SizedBox(width: 5.w,),
                  PhotoButton(label: "SI", callback: () async {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => Recognition(
                        imagePath: imagePath,
                        user: user
                      ),
                    ));
                  },)
              ],
            ),
          )
        ],
      ),
      backgroundColor: kMainColor,
    );
  }
}

class PhotoButton extends StatelessWidget {
  const PhotoButton({
    Key? key, required String this.label, required Function() this.callback
  }) : super(key: key);

  final String label;
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback, 
      child: Text(label),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
            vertical: 1.5.h, horizontal: 15.w
        ),
        primary: label == "NO" ? kSecondaryColor.withOpacity(0.3) : kSecondaryColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(15, 15))),
      ),
    );
  }
}

