import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latLng;

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
  MapMarker(location: latLng.LatLng(44.6977207, 10.6308046), image: Image.asset("assets/images/duomo.jpg"), title: "Duomo di Reggio Emilia" ),
  MapMarker(location: latLng.LatLng(44.7008133, 10.6312801), image: Image.asset("assets/images/museicivici.jpg"), title: "Teatro Municipale")
];