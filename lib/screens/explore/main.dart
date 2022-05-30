import 'package:flutter/material.dart';
import 'package:time_travel/utils/constants.dart';
import 'package:time_travel/utils/markers.dart';

class ExplorePage extends StatelessWidget {
  final MapMarker data;
  const ExplorePage({ Key? key, required MapMarker this.data }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kMainColor,
      child: Column(
        children: [
          data.image
        ],
      ),
    );
  }
}