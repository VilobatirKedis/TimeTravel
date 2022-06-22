import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:time_travel/utils/constants.dart';
import 'package:time_travel/screens/map/markers.dart';

class ExplorePage extends StatelessWidget {
  final MapMarker data;
  const ExplorePage({ Key? key, required MapMarker this.data }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kMainColor,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            child: data.image,
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Text(
              data.title,
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 25.sp,
                fontWeight: FontWeight.w200,
                color: Colors.white
              ),
            ),
          ),
          Card(
            color: kMainColor.withOpacity(0.6),
            child: Row(
              children: [
                Text("Teatro"), 
              ]
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                "TeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatro",
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 15.sp
                ),
              )
            ),
          )
        ],
      )
    );


    /*return Container(
      color: kMainColor,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            child: data.image,
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Text(
              data.title,
              style: GoogleFonts.montserrat(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 25.sp,
                fontWeight: FontWeight.w200,
                color: Colors.white
              ),
            ),
          ),
          Card(
            color: kMainColor.withOpacity(0.6),
            child: Row(
              children: [
                Text("Teatro"), 
              ]
            ),
          ),
          const SingleChildScrollView(
            child: Text("TeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatroTeatro")
          ),
        ],
      ),
    );*/
  }
}