import 'dart:io';
import 'package:flutter/material.dart';
import 'package:time_travel/utils/constants.dart';

class PhotoPreview extends StatelessWidget {
  final String imagePath;

  const PhotoPreview({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
      backgroundColor: kMainColor,
    );
  }
}

