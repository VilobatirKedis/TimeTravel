import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
//import 'package:time_travel/screens/camera/main.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:time_travel/utils/auth_service.dart';
import 'package:time_travel/utils/constants.dart';

import '../../utils/location.dart';
import '../camera/main.dart';

Future<CameraDescription> openCameras() async {
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  return firstCamera;
}

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
    const String token = 'sk.eyJ1Ijoidmlsb2tlZGlzIiwiYSI6ImNsMmFyN2cyMzA2N2wzam5yejQ4eWo5ZTgifQ.jNioMcy0j9nicWrxUQqnRQ';
    const String style = 'mapbox://styles/vilokedis/cl2asom8j001l14rvm832r12s';
    Size size = MediaQuery.of(context).size;
    print(size.width);
    
    return Stack(
      children: [ 
        Scaffold(
          body: MapboxComponent(token: token, style: style),
          floatingActionButton: ElevatedButton(
            onPressed: () {
              FutureBuilder(
                future: openCameras(),
                builder: (context, AsyncSnapshot<CameraDescription> snapshot) {
                  if(snapshot.hasData) {  
                    return TakePictureScreen(camera: snapshot.data!);
                  }
      
                  else return const CircularProgressIndicator();
                },
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
        ),
        SafeArea(
          child: ElevatedButton.icon(
            onPressed: () {}, 
            icon: Icon(Icons.more_horiz_rounded),
            label: Text(''),
            style: ElevatedButton.styleFrom(
            )
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
      attributionButtonPosition: AttributionButtonPosition.TopRight,
      compassViewPosition: CompassViewPosition.TopRight,
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