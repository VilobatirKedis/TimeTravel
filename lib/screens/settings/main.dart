import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:time_travel/utils/constants.dart';


class Settings extends StatelessWidget {
  Settings({ Key? key }) : super(key: key);

  String language = "Italiano";

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: kMainColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 3.h, left: 3.w),
                child: Row(
                  children: [
                    Material(
                      color: Colors.transparent,
                      shadowColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        }, 
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 30
                        )
                      ),
                    ),
    
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text(
                        "Settings.",
                        style: GoogleFonts.montserrat(
                          textStyle: Theme.of(context).textTheme.headline4,
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: ListTile(
                        onTap: () {
                          
                        },
                        leading: Icon(
                          Icons.language_rounded,
                          color: kSecondaryColor,
                          size: 25.sp,
                        ),
                        title: Text('Language',
                          style: GoogleFonts.montserrat(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        trailing: Text(language,
                          style: GoogleFonts.montserrat(
                            fontSize: 10.sp,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: ListTile(
                        onTap: () {
                          
                        },
                        leading: Icon(
                          Icons.location_on_rounded,
                          color: kSecondaryColor,
                          size: 25.sp,
                        ),
                        title: Text('Position permissions',
                          style: GoogleFonts.montserrat(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        trailing: Text("ON",
                          style: GoogleFonts.montserrat(
                            fontSize: 10.sp,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: ListTile(
                        onTap: () {
                          
                        },
                        leading: Icon(
                          Icons.camera_rounded,
                          color: kSecondaryColor,
                          size: 25.sp,
                        ),
                        title: Text('Camera permissions',
                          style: GoogleFonts.montserrat(
                            fontSize: 15.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        trailing: Text("ON",
                          style: GoogleFonts.montserrat(
                            fontSize: 10.sp,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}