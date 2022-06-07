import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:sizer/sizer.dart';
import 'package:time_travel/screens/explore/main.dart';


import 'package:time_travel/utils/constants.dart';
import 'package:time_travel/utils/location.dart';
import 'package:time_travel/utils/markers.dart';


class MapComponent extends StatefulWidget {
  const MapComponent({ Key? key, required this.controller}) : super(key: key);

  final controller;

  @override
  State<MapComponent> createState() => _MapComponentState();
}

class _MapComponentState extends State<MapComponent> {
  final String publicToken = 'pk.eyJ1Ijoidmlsb2tlZGlzIiwiYSI6ImNsMmFxNjV2MDA3d2szZXJ1dXBqb2Y4d3kifQ.we7gt1JJFXtMBG9d4mx7TA';
  final String fullPathStyle = 'https://api.mapbox.com/styles/v1/vilokedis/cl37lp0ft000114p1ps7c8uvk/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoidmlsb2tlZGlzIiwiYSI6ImNsMmFxNjV2MDA3d2szZXJ1dXBqb2Y4d3kifQ.we7gt1JJFXtMBG9d4mx7TA';

  static late PageController currentController;
  List<Marker> locationMarker = [];

  @override
  void initState() {
    currentController = widget.controller;
    for (var i = 0; i < dataMarker.length; i++) {
      locationMarker.add(
        Marker(
          width: 40,
          height: 40,
          point: dataMarker[i].location, 
          builder: (context) {
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context, 
                  builder: (context) {
                    return OpenContainer(
                      closedBuilder: (BuildContext context, void Function() openContainer) {  
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: dataMarker[i].image,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 2.h),
                                child: Text(
                                  dataMarker[i].title,
                                  style: GoogleFonts.montserrat(
                                    textStyle: Theme.of(context).textTheme.headline4,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white
                                  )
                                ),
                              ),
                              ExploreButton(widgetIn: openContainer,),
                            ],

                          ),
                        );
                      },
                      closedColor: Colors.transparent,
                      closedElevation: 0, 
                      
                      openBuilder: (BuildContext context, void Function({Object? returnValue}) action) {  
                        return ExplorePage(data: dataMarker[i]);
                      },
                      openColor: Colors.transparent,
                      openElevation: 0,

                      transitionDuration: Duration(milliseconds: 450),      
                    );
                  }
                );
              },
              child: markerImage
            );
          }
        )
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<latLng.LatLng>(
      future: acquireCurrentLocation(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return FlutterMap(
            layers: [
              MarkerLayerOptions(
                markers: locationMarker
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
              center: snapshot.data,
              rotationThreshold: 50000,
              zoom: 10.sp
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
                  mapMarker.title,
                  style: TextStyle(
                    color: Colors.white
                  ),
                )
              ],
            )
          )
        ]
      ),
    );
  }
}
