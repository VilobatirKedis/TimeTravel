import 'dart:math';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:provider/provider.dart';
import 'package:time_travel/screens/authentication/log_in.dart';
import 'package:time_travel/screens/camera/main.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:time_travel/utils/auth_service.dart';
import 'package:time_travel/utils/constants.dart';

import '../../utils/location.dart';

MapboxMapController? globalController = null;

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
    const String token =
        'sk.eyJ1Ijoidmlsb2tlZGlzIiwiYSI6ImNsMmFyN2cyMzA2N2wzam5yejQ4eWo5ZTgifQ.jNioMcy0j9nicWrxUQqnRQ';
    const String style = 'mapbox://styles/vilokedis/cl2hy1oal003w14o7008xs3s1';

    Size size = MediaQuery.of(context).size;

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);

    return Stack(children: [
      Scaffold(
        key: _scaffoldKey,
        body: MapboxComponent(token: token, style: style),
        floatingActionButton: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CameraScreen()),
              );
            },
            icon: Icon(Icons.camera_alt_rounded),
            label: Text(
              "SCAN A MONUMENT",
              style: TextStyle(fontSize: size.width * 0.04),
            ),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                padding: EdgeInsets.fromLTRB(
                    size.width * 0.23,
                    size.height * 0.017,
                    size.width * 0.23,
                    size.height * 0.017),
                primary: kMainColor)),
        drawer: Drawer(
            elevation: 9999,
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  child: Text("Time Travel"),
                  decoration: BoxDecoration(color: kMainColor),
                  padding: EdgeInsets.all(55),
                ),
                ListTile(
                  title: const Text('Log Out'),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LogInPage(),
                      ),
                    );
                  },
                )
              ],
            )),
      ),
      SafeArea(
          child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
            child: ElevatedButton.icon(
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              icon: const Icon(Icons.more_horiz_rounded,
                  color: kMainColor, size: 28),
              label: const Text(''),
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.fromLTRB(7.5, 10, 0, 10),
                  primary: Colors.white),
            ),
          ),
          Padding(padding: EdgeInsets.only(left: size.width * 0.635)),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
            child: ElevatedButton.icon(
              onPressed: () async {
                final result = await acquireCurrentLocation();

                await globalController?.animateCamera(
                  CameraUpdate.newLatLng(result),
                );
              },
              icon: const Icon(Icons.location_pin, color: kMainColor, size: 28),
              label: const Text(''),
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.fromLTRB(7.5, 10, 0, 10),
                  primary: Colors.white),
            ),
          ),
        ],
      ))
    ]);
  }
}

class MapboxComponent extends StatelessWidget {
  const MapboxComponent({
    Key? key,
    required this.token,
    required this.style,
  }) : super(key: key);

  final String token;
  final String style;

  @override
  Widget build(BuildContext context) {
    return MapboxMap(
        accessToken: token,
        styleString: style,
        attributionButtonMargins: const Point(-30, -30),
        logoViewMargins: const Point(-30, -30),
        compassViewMargins: const Point(-30, -30),
        trackCameraPosition: true,
        myLocationEnabled: true,
        myLocationRenderMode: MyLocationRenderMode.COMPASS,
        myLocationTrackingMode: MyLocationTrackingMode.TrackingCompass,
        initialCameraPosition: const CameraPosition(
          zoom: 15.0,
          target: LatLng(14.508, 46.048),
        ),
        onMapCreated: (MapboxMapController controller) async {
          globalController = controller;
          final result = await acquireCurrentLocation();

          await controller.animateCamera(
            CameraUpdate.newLatLng(result),
          );
        });
  }
}
