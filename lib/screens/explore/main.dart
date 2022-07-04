import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:time_travel/utils/apiInterface.dart';

import 'package:time_travel/utils/constants.dart';
import 'package:time_travel/utils/monumentJSON.dart';

class ExplorePage extends StatelessWidget {
  //final MapMarker data;
  const ExplorePage({ Key? key, required this.monument, this.imageData, required this.mode}) : super(key: key);

  final MonumentsData monument;
  final Uint8List? imageData;
  final String mode;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: kMainColor,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
              child: SizedBox(
                height: 260,
                child: FutureBuilder<List<Uint8List>>(
                  future: getImagesOfMonument(monument.id, mode),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Image.memory(snapshot.data![index]);
                        }, 
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 5,);
                        }, 
                        itemCount: snapshot.data!.length
                      );
                    }
    
                    else return const Center(
                          child: CircularProgressIndicator(
                            color: kSecondaryColor,
                            backgroundColor: kMainColor,
                          ),
                        );
                  }
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
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Card(
                color: kSecondaryColor.withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Tipo: " + monument.type! + " Funzione: " + monument.typeDescription!,
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w200
                            ),
    
                          ),
                        ]
                      ),
                      Text(
                        "Valutazione: " + ((monument.votes_sum / monument.number_of_votes).isNaN ? "Nessuna valutazione" : ((monument.votes_sum / monument.number_of_votes).toString()) + " su 5"),
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w200
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    monument.it_description,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w200
                    ),
                  ),
                )
              ),
            )
          ],
        )
      ),
    );
  }
}