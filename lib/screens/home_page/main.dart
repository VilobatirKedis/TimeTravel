import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:time_travel/screens/camera/main.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:time_travel/utils/constants.dart';

import '../../utils/location.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    const String token = 'sk.eyJ1Ijoidmlsb2tlZGlzIiwiYSI6ImNsMmFyN2cyMzA2N2wzam5yejQ4eWo5ZTgifQ.jNioMcy0j9nicWrxUQqnRQ';
    const String style = 'mapbox://styles/vilokedis/cl2hy1oal003w14o7008xs3s1';
    Size size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    
    return Stack(
      children: [ 
        Scaffold(
          key: _scaffoldKey,
          body: MapboxComponent(token: token, style: style),
          floatingActionButton: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CameraScreen()),
              );
            }, 
            child: Text(
              "SCAN A MONUMENT",
              style: TextStyle(
                fontSize: size.width * 0.04
              ),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50)
              ),
              padding: EdgeInsets.fromLTRB(size.width * 0.27, 14, size.width * 0.27, 14),
              primary: kMainColor
            )
          ),
          drawer: Drawer(
            elevation: 1000,
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  title: const Text('Item 1'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: const Text('Item 2'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            )
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: ElevatedButton.icon(
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              }, 
              icon: const Icon(Icons.more_horiz_rounded),
              label: const Text(''),
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.fromLTRB(7.5, 10, 0, 10),
                primary: kMainColor
              ),
            ),
          )
        )
      ]
    );
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
      attributionButtonMargins: const Point(-30,-30),
      logoViewMargins: const Point(-30,-30),
      compassViewMargins: const Point(-30,-30),
      initialCameraPosition: const CameraPosition(
        zoom: 15.0,
        target: LatLng(14.508, 46.048),
      ),
      
      onMapCreated: (MapboxMapController controller) async {
        final result = await acquireCurrentLocation();
        
        await controller.animateCamera(
          CameraUpdate.newLatLng(result),
        );

        await controller.addCircle(
          CircleOptions(
            circleRadius: 8.0,
            circleColor: '#006992',
            circleOpacity: 0.8,
            
            geometry: result,
            draggable: false,
          ),
        );
      }
    );
  }
}