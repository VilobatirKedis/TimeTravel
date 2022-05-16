import 'package:location/location.dart';
import 'package:latlong2/latlong.dart' as latLng;

Future<latLng.LatLng> acquireCurrentLocation() async {
  Location location = Location();

  bool serviceEnabled;
  
  
  PermissionStatus permissionGranted;

  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return latLng.LatLng(0, 0);
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return latLng.LatLng(0, 0 );
    }
  }

  final locationData = await location.getLocation();
  return latLng.LatLng(locationData.latitude!, locationData.longitude!);
}