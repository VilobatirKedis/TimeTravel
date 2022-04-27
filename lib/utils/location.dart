import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

Future<LatLng> acquireCurrentLocation() async {
  Location location = Location();

  bool serviceEnabled;
  
  
  PermissionStatus permissionGranted;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return const LatLng(0, 0);
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return const LatLng(0, 0 );
    }
  }

  final locationData = await location.getLocation();
  return LatLng(locationData.latitude!, locationData.longitude!);
}