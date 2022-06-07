import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:time_travel/utils/constants.dart';


class Settings extends StatelessWidget {
  const Settings({ Key? key }) : super(key: key);

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
                    ListTile(
                      onTap: () {
                        
                      },
                      title: Text("Language"),
                      trailing: Icon(Icons.arrow_drop_down_rounded),
                    )
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