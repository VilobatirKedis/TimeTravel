import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:time_travel/screens/authentication/log_in.dart';
import 'package:time_travel/utils/auth_service.dart';

import 'package:time_travel/utils/constants.dart';
import 'package:time_travel/utils/location.dart';
import 'package:time_travel/screens/camera/main.dart';


final _pageController = PageController();
final Image markerImage = Image.asset(
  "assets/images/marker.png",
  scale: 30,
);

class MapMarker {
  const MapMarker({
    required this.location,
    required this.image,
    required this.title
  });

  final location;
  final image;
  final title;
}

List<MapMarker> dataMarker = [
  MapMarker(location: latLng.LatLng(44.6977207, 10.6308046), image: Image.asset("assets/images/museicivici.jpg"), title: "Teatro Municipale"),
  MapMarker(location: latLng.LatLng(44.7008133, 10.6312801), image: Image.asset("assets/images/museicivici.jpg"), title: "Cattedrale di Santa Maria Assunta")
];

List<Marker> locationMarker = [
  Marker(
    width: 80,
    height: 80,
    point: dataMarker[0].location,
    builder: (context) => 
    GestureDetector(
      
      onTap: () {
        print("ciao");
        _pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.bounceInOut);
      },
      child: Container(
        height: 40,
        width: 40,
        child: markerImage
      ),
    )
  ),
  Marker(
    width: 80,
    height: 80,
    point: dataMarker[1].location,
    builder: (_) => 
    GestureDetector(
      
      onTap: () {
        print("bella");
        _pageController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.bounceInOut);
      },
      child: Container(
        height: 40,
        width: 40,
        child: markerImage
      ),
    )
  ),
];

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
    const String token = 'sk.eyJ1Ijoidmlsb2tlZGlzIiwiYSI6ImNsMmFyN2cyMzA2N2wzam5yejQ4eWo5ZTgifQ.jNioMcy0j9nicWrxUQqnRQ';
    const String publicToken = 'pk.eyJ1Ijoidmlsb2tlZGlzIiwiYSI6ImNsMmFxNjV2MDA3d2szZXJ1dXBqb2Y4d3kifQ.we7gt1JJFXtMBG9d4mx7TA';
    
    const String style = 'mapbox://styles/vilokedis/cl37lp0ft000114p1ps7c8uvk';
    const String fullPathStyle = 'https://api.mapbox.com/styles/v1/vilokedis/cl37lp0ft000114p1ps7c8uvk/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoidmlsb2tlZGlzIiwiYSI6ImNsMmFxNjV2MDA3d2szZXJ1dXBqb2Y4d3kifQ.we7gt1JJFXtMBG9d4mx7TA';
    final userToken = _currentUser.getIdToken();

    Size size = MediaQuery.of(context).size;
    setStatusBarColor(Colors.transparent);

    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Stack(children: [
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.01),
          child: DrawerButton(scaffoldKey: _scaffoldKey),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: size.height * 0.01, left: size.width * 0.75),
          child: const LocationButton(),
        ),
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.875),
          child: ScanButton(size: size),
        ),
      ]),
      body: /*Stack(
        children: [*/
          const MapComponent(token: publicToken, style: fullPathStyle),
          /*Positioned(
            left: 20,
            right: 20,
            bottom: 80,
            height: size.height * 0.1,
            child: PageView.builder(
              controller: _pageController,
              itemCount: dataMarker.length,
              itemBuilder: (context, index) {
                final item = dataMarker[index];
                return MapItemCard(mapMarker: item);
              },
            ),
          )
        ],
      ),*/
      drawer: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: Drawer(
            backgroundColor: kMainColor,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.05),
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
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.025, top: size.height * 0.02),
                  child: Column(
                    children: [
                      ListTile(
                        autofocus: true,
                        focusColor: kSecondaryColor,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                      user: _currentUser,
                                    )),
                          );
                        },
                        leading: Icon(
                          Icons.map_rounded,
                          color: Colors.white,
                        ),
                        title: Text("Map",
                            style: GoogleFonts.montserrat(
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.settings_rounded,
                          color: Colors.white,
                        ),
                        title: Text("Settings",
                            style: GoogleFonts.montserrat(
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                fontSize: size.width * 0.05,
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
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class MapItemCard extends StatelessWidget {
  const MapItemCard({ Key? key, required this.mapMarker }) : super(key: key);

  final MapMarker mapMarker;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kMainColor,
      child: Row(
        children: [
          Expanded(
            child: mapMarker.image
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  mapMarker.title
                )
              ],
            )
          )
        ]
      ),
    );
  }
}

class ScanButton extends StatelessWidget {
  const ScanButton({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

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
            fontSize: size.width * 0.035,
            fontWeight: FontWeight.w600,
            color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.015, horizontal: size.width * 0.24),
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

/*class MapboxComponent extends StatefulWidget {
  const MapboxComponent({
    Key? key,
    required this.token,
    required this.style,
  }) : super(key: key);

  final String token;
  final String style;

  @override
  State<MapboxComponent> createState() => _MapboxComponentState();
}

class _MapboxComponentState extends State<MapboxComponent> {
  @override
  Widget build(BuildContext context) {
    return MapboxMap(
      accessToken: widget.token,
      styleString: widget.style,
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

        controller.addSymbols(localita);

        final result = await acquireCurrentLocation();

        await controller.animateCamera(
          CameraUpdate.newLatLng(result),
        );
      }
    );
  }
}*/

class MapComponent extends StatefulWidget {
  const MapComponent({ Key? key,
    required this.token,
    required this.style, }) : super(key: key);

  final String token;
  final String style;

  @override
  State<MapComponent> createState() => _MapComponentState();
}

class _MapComponentState extends State<MapComponent> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<latLng.LatLng>(
      future: acquireCurrentLocation(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return FlutterMap(
            children: [
              TileLayerWidget(
                options: TileLayerOptions(
                  urlTemplate: widget.style,
                  additionalOptions:  {
                    "accessToken": widget.token,
                  }
                ),
              ),
              MarkerLayerWidget(
                options: MarkerLayerOptions(
                  markers: locationMarker
                ),
              ),
              LocationMarkerLayerWidget(
                options: LocationMarkerLayerOptions(
                  marker: const DefaultLocationMarker(
                    color: kSecondaryColor,
                  ),
                  markerSize: const Size(20, 20),
                  accuracyCircleColor: kSecondaryColor.withOpacity(0.1),
                  headingSectorColor: kSecondaryColor.withOpacity(0.8),
                  headingSectorRadius: 50,
                  markerAnimationDuration: Duration.zero,
                ),
                
              )
            ],
            options: MapOptions(
              center: snapshot.data,
              rotationThreshold: 1000
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            color: kSecondaryColor,
            backgroundColor: kMainColor,
          ),
        );
      }
    );
  }
}
