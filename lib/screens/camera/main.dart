import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:time_travel/utils/constants.dart';

import '../../main.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';


class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with WidgetsBindingObserver {

  CameraController? controller;
  bool _isCameraInitialized = false;

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    // Dispose the previous controller
    await previousCameraController?.dispose();

    // Replace with the new controller
    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    // Update UI if controller updated
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });

    // Initialize controller
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }

    // Update the Boolean
    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  Future<XFile?> takePicture() async {
  final CameraController? cameraController = controller;
  if (cameraController!.value.isTakingPicture) {
    // A capture is already pending, do nothing.
    return null;
  }
  try {
    XFile file = await cameraController.takePicture();
    return file;
  } on CameraException catch (e) {
    print('Error occured while taking picture: $e');
    return null;
  }
}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    onNewCameraSelected(cameras[0]);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: _isCameraInitialized
              ? AspectRatio(
                  aspectRatio: 1 / controller!.value.aspectRatio,
                  child: controller!.buildPreview(),
                )
              : Container(),
        ),
        SafeArea(
          child: ElevatedButton(
            onPressed: () async {
              XFile? rawImage = await takePicture();
              File imageFile = File(rawImage!.path);
        
              int currentUnix = DateTime.now().millisecondsSinceEpoch;
              final directory = await getApplicationDocumentsDirectory();
              String fileFormat = imageFile.path.split('.').last;
        
              await imageFile.copy(
                '${directory.path}/$currentUnix.$fileFormat',
              );
            },
            child: const Text(''),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(24),
              primary: kMainColor
            ),
          ),
        )
      ]
    );
  }
}