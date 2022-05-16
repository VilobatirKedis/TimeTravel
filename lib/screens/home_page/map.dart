import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart' as latLng;


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

  @override
  void initState() {
    currentController = widget.controller;
    super.initState();
  }

  List<Marker> locationMarker = [
    Marker(
      width: 80,
      height: 80,
      point: dataMarker[0].location,
      builder: (context) {
        return TextButton(
          onPressed: () {
            print("ciao");
            currentController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.bounceInOut);
          },
          child: markerImage
        );
      }
    ),
    Marker(
      width: 80,
      height: 80,
      point: dataMarker[1].location,
      builder: (_) { 
        return TextButton(
          onPressed: () {
            print("ciao");
            currentController.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.bounceInOut);
          },
          child: Text("Ciao")
        );
      }
    ),
  ];

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
                  urlTemplate: fullPathStyle,
                  additionalOptions:  {
                    "accessToken": publicToken,
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
