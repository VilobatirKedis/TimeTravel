import 'dart:convert';
import 'dart:typed_data';

import 'package:animations/animations.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:sizer/sizer.dart';

import 'package:time_travel/screens/explore/main.dart';
import 'package:time_travel/utils/apiInterface.dart';
import 'package:time_travel/utils/constants.dart';
import 'package:time_travel/utils/location.dart';
import 'package:time_travel/utils/monumentJSON.dart';


class MapComponent extends StatefulWidget {
  const MapComponent({ Key? key, required this.token}) : super(key: key);
  final token;

  @override
  State<MapComponent> createState() => _MapComponentState();
}

class _MapComponentState extends State<MapComponent> {
  final String publicToken = 'pk.eyJ1Ijoidmlsb2tlZGlzIiwiYSI6ImNsMmFxNjV2MDA3d2szZXJ1dXBqb2Y4d3kifQ.we7gt1JJFXtMBG9d4mx7TA';
  final String fullPathStyle = 'https://api.mapbox.com/styles/v1/vilokedis/cl37lp0ft000114p1ps7c8uvk/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoidmlsb2tlZGlzIiwiYSI6ImNsMmFxNjV2MDA3d2szZXJ1dXBqb2Y4d3kifQ.we7gt1JJFXtMBG9d4mx7TA';

  @override
  void initState() {
    final storageRef = FirebaseStorage.instance.ref();
    super.initState();
  }

  Future<List<Marker>> serializeMonuments() async {
    List<dynamic> monumentsMap;
    List<MonumentsData> monuments = [];
    List<Marker> mapMarkers = [];

    var response = await getAllMonuments(widget.token);
    monumentsMap = jsonDecode(response);
    for(var object in monumentsMap[0][0]) {
      monuments.add(MonumentsData.fromJson(object));
    }

    for(var monument in monuments) {
      mapMarkers.add(
        Marker(
          width: 40,
          height: 40,
          point: latLng.LatLng(monument.latitude, monument.longitude), 
          builder: (context) {
            return MonumentBottomCard(monument: monument);
          }
        )
      );
    } 

    return mapMarkers;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<latLng.LatLng>(
      future: acquireCurrentLocation(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          var currentLocation = snapshot.data!;
          return FutureBuilder<List<Marker>>(
            future: serializeMonuments(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FlutterMap(
                  layers: [
                    MarkerLayerOptions(
                      markers: snapshot.data!
                    ),
                  ],
                  children: <Widget>[
                    TileLayerWidget(
                      options: TileLayerOptions(
                        keepBuffer: 20,
                        tileProvider: NetworkTileProvider(),
                        updateInterval: 100,
                        urlTemplate: fullPathStyle,
                        additionalOptions:  {
                          "accessToken": publicToken,
                        }
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
                    center: currentLocation,
                    rotationThreshold: 50000,
                    zoom: 10.sp
                  ),
                );
              }

              else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: kSecondaryColor,
                    backgroundColor: kMainColor,
                  ),
                );
              }
            }
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

class MonumentBottomCard extends StatelessWidget {
  MonumentBottomCard({
    Key? key, required this.monument
  }) : super(key: key);

  final MonumentsData monument;
  Uint8List imageData = Uint8List(0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context, 
          builder: (context) {
            return OpenContainer(
              closedBuilder: (BuildContext context, void Function() openContainer) {  
                return FutureBuilder<Uint8List>(
                  future: getImageOfMonument(monument.id),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      imageData = snapshot.data!;  
                      return Container(
                        height: 90.h,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                          color: kMainColor,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 2.h),
                              child: SizedBox(
                                width: 45.w,
                                height: 0.5.h,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                              child: SizedBox(
                                height: 250,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.memory(
                                    imageData
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 2.h),
                              child: Text(
                                monument.real_name,
                                style: GoogleFonts.montserrat(
                                  textStyle: Theme.of(context).textTheme.headline4,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white
                                )
                              ),
                            ),
                            ExploreButton(widgetIn: openContainer),
                          ],
                  
                        ),
                      );
                    }

                    else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kSecondaryColor,
                          backgroundColor: kMainColor,
                        ),
                      );
                    }
                  }
                );
              },
              closedColor: Colors.transparent,
              closedElevation: 0, 
              
              openBuilder: (BuildContext context, void Function({Object? returnValue}) action) {  
                return ExplorePage(monument: monument, imageData: imageData);
              },
              openColor: Colors.transparent,
              openElevation: 0,

              transitionDuration: Duration(milliseconds: 450),      
            );
          }
        );
      },
      child: Image.asset("assets/images/marker.png")
    );
  }
}

class ExploreButton extends StatelessWidget {
  final void Function() widgetIn;
  
  const ExploreButton({
    Key? key, required this.widgetIn
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: ElevatedButton(
        onPressed: () async {
          widgetIn();
        },
        child: Text(
          "Scopri di piu'",
          style: GoogleFonts.montserrat(
              textStyle: Theme.of(context).textTheme.headline4,
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
              horizontal: 30.w,
              vertical: 2.h),
          primary: kSecondaryColor,
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.elliptical(15, 15))),
        ),
      ),
    );
  }
}