import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:time_travel/utils/constants.dart';
import 'package:time_travel/utils/monumentJSON.dart';

class ExplorePage extends StatelessWidget {
  //final MapMarker data;
  const ExplorePage({ Key? key, required this.monument, required this.imageData}) : super(key: key);

  final MonumentsData monument;
  final Uint8List imageData;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kMainColor,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            child: SizedBox(
              height: 250,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if(index > 0 && index < 3)return const SizedBox(width: 10);
                  else return Container();
                }, 
                separatorBuilder: (context, index) {
                  return Image.memory(imageData);
                }, 
                itemCount: 4
              ),
            )
          ),
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Text(
              monument.realName,
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