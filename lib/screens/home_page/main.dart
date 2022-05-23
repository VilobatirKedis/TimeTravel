import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:time_travel/screens/authentication/logIn.dart';
import 'package:time_travel/screens/home_page/map.dart';
import 'package:time_travel/screens/settings/main.dart';
import 'package:time_travel/utils/authService.dart';
import 'package:time_travel/utils/constants.dart';
import 'package:time_travel/utils/location.dart';
import 'package:time_travel/screens/camera/main.dart';
import 'package:time_travel/utils/markers.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    setStatusBarColor(Colors.transparent);

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    var pageController = PageController();
    final userToken = _currentUser.getIdToken();

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Stack(children: [
        Padding(
          padding: EdgeInsets.only(top: 1.h),
          child: DrawerButton(scaffoldKey: _scaffoldKey),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: 1.h, left: 70.w),
          child: const LocationButton(),
        ),
        Padding(
          padding: EdgeInsets.only(top: 87.h),
          child: ScanButton(),
        ),
      ]),
      body: Stack(
        children: [
          MapComponent(controller: pageController),
        ],
      ),
      drawer: ClipRRect(
        borderRadius: const BorderRadius.only(
        topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: Drawer(
          backgroundColor: kMainColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: _currentUser.photoURL != null
                            ? Image.network(_currentUser.photoURL!)
                            : FlutterLogo()),
                  ),
                  title: Text(
                    _currentUser.displayName != null
                        ? _currentUser.displayName!
                        : _currentUser.email!,
                    style: GoogleFonts.montserrat(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white
                    )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.w, top: 2.h),
                child: Column(
                  children: [
                    ListTile(
                      shape: const RoundedRectangleBorder(
                        borderRadius:  BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30),)
                      ),
                      selected: true,
                      selectedTileColor: kSecondaryColor,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      leading: Icon(
                        Icons.map_rounded,
                        color: Colors.white,
                      ),
                      title: Text("Map",
                          style: GoogleFonts.montserrat(
                              textStyle:
                                  Theme.of(context).textTheme.headline4,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Settings()
                          )
                        );
                      },
                      leading: const Icon(
                        Icons.settings_rounded,
                        color: Colors.white,
                      ),
                      title: Text("Settings",
                          style: GoogleFonts.montserrat(
                              textStyle:
                                  Theme.of(context).textTheme.headline4,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ),
                    ListTile(
                      onTap: () async {
                        if (_currentUser.providerData[0].providerId
                            .contains("google")) {
                          await AuthenticationService.signOutFromGoogle();
                        } else {
                          await FirebaseAuth.instance.signOut();
                        }

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LogInPage(),
                          ),
                        );
                      },
                      leading: Icon(
                        Icons.logout_rounded,
                        color: Colors.white,
                      ),
                      title: Text("Log Out",
                          style: GoogleFonts.montserrat(
                              textStyle:
                                  Theme.of(context).textTheme.headline4,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}

class ScanButton extends StatelessWidget {
  const ScanButton({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CameraScreen()),
        );
      },
      icon: Icon(Icons.camera_alt_rounded),
      label: Text(
        "SCAN A MONUMENT",
        style: GoogleFonts.montserrat(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
            vertical: 1.5.h, horizontal: 18.w),
        primary: kSecondaryColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(15, 15))),
      ),
    );
  }
}

class LocationButton extends StatelessWidget {
  const LocationButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        final result = await acquireCurrentLocation();

        /*await globalController?.animateCamera(
          CameraUpdate.newLatLng(result),
        );*/
      },
      icon: const Icon(Icons.location_pin, color: kMainColor, size: 28),
      label: const Text(''),
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.fromLTRB(7.5, 10, 0, 10),
          primary: Colors.white),
    );
  }
}

class DrawerButton extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const DrawerButton({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  State<DrawerButton> createState() => _DrawerButtonState();
}

class _DrawerButtonState extends State<DrawerButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        widget.scaffoldKey.currentState?.openDrawer();
      },
      icon: const Icon(Icons.more_horiz_rounded, color: kMainColor, size: 28),
      label: const Text(''),
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.fromLTRB(7.5, 10, 0, 10),
          primary: Colors.white),
    );
  }
}