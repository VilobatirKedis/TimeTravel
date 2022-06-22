import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:time_travel/utils/constants.dart';
import 'package:time_travel/utils/monumentJSON.dart';

class ExplorePage extends StatelessWidget {
  //final MapMarker data;
  const ExplorePage({ Key? key, required this.monument}) : super(key: key);

  final MonumentsData monument;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kMainColor,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            child: Text("IMMAGINE")//data.image,
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Text(
              monument.real_name,
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
                "DESCRIZIONE",
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
  }
}