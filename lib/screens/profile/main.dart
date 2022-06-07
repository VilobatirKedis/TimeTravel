import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:time_travel/screens/visited_monuments/main.dart';
import 'package:time_travel/utils/constants.dart';


class Profile extends StatelessWidget {
  final user;
  const Profile({ Key? key, required User this.user }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
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
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      }, 
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 30
                      )
                    ),
    
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text(
                        "Profile.",
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
                      child: Center(
                        child: SizedBox(
                          width: 95,
                          height: 95,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            child: user.photoURL != null
                                ? Image.network(user.photoURL!)
                                : Image.asset("assets/images/defaultuser.jpg")
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Center(
                        child: Text(
                          user.displayName != null
                              ? user.displayName!
                              : user.email!.split("@")[0],
                          style: GoogleFonts.montserrat(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                          )
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
                      child: Center(
                        child: Text(
                          user.email!,
                          style: GoogleFonts.montserrat(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w200,
                            color: Colors.white
                          )
                        ),
                      ),
                    ),
                    const Divider(
                      color: kSecondaryColor,
                      thickness: 2,
                      indent: 60,
                      endIndent: 60,
                    ),
                    Padding(
                      padding:  EdgeInsets.only(top: 2.h),
                      child: ListTile(
                        enableFeedback: true,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => VisitedMonuments()
                            )
                          );
                        },
                        leading: Icon(
                          Icons.location_city_rounded,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        title: Text(
                          "Visited monuments",
                          style: GoogleFonts.montserrat(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w300,
                            color: Colors.white
                          )
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}