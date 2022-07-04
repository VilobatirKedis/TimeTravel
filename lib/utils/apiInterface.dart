import 'dart:ffi';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

Future<String> testGet(String userToken) async {
  var headers = {
    "authorization": userToken
  };

  var url = Uri.parse('https://time-travel-bp.herokuapp.com/', );
  var response = await http.get(url, headers: headers);
  
  return response.body;
}

Future<String> getAllMonuments(String userToken) async {
  var headers = {
    "authorization": userToken
  };

  var url = Uri.parse('https://time-travel-bp.herokuapp.com/monuments/all');
  var response = await http.get(url, headers: headers);

  return response.body;
}

Future<String> getAllMonumentTypes(String userToken) async {
  var headers = {
    "authorization": userToken
  };

  var url = Uri.parse('https://time-travel-bp.herokuapp.com/monument_types/all');
  var response = await http.get(url, headers: headers);

  return response.body;
}

Future<String> getAllTypesOfMonument(String userToken) async {
  var headers = {
    "authorization": userToken
  };

  var url = Uri.parse('https://time-travel-bp.herokuapp.com/types_of_monuments/all');
  var response = await http.get(url, headers: headers);

  return response.body;
}

Future<Uint8List> getMainImageOfMonument(int monumentID) async {
  final storageRef = FirebaseStorage.instance.ref();

  Uint8List imageData = Uint8List(0);

  /*var response = await http.get(Uri.parse('https://storage.googleapis.com/cms-storage-bucket/75c5b74c32dfd7b7e8f3.jpg'));
  imageData = response.bodyBytes;*/

  await storageRef
    .child(monumentID.toString() + "/" + monumentID.toString() + "_main.jpg")
    .getData(100000000)
    .then((value) => {imageData = value!})
    .catchError((error) => {throw error.toString()});

  return imageData;
}

Future<List<Uint8List>> getImagesOfMonument(int monumentID, String mode) async {
  List<Uint8List> imagesData = [];

  /*for(var i = 0; i < 5; i++) {
    var response = await http.get(Uri.parse('https://storage.googleapis.com/cms-storage-bucket/75c5b74c32dfd7b7e8f3.jpg'));
    imagesData.add(response.bodyBytes);
  }*/


  final storageRef = FirebaseStorage.instance.ref();
  final allImages = mode == "current" ? await storageRef.child(monumentID.toString()).listAll() : await storageRef.child(monumentID.toString() + "/old").listAll();
  print(allImages);

  for(var item in allImages.items) {
    print(item.name);
    await item
      .getData(100000000)
      .then((value) => {imagesData.add(value!)});
  }
  
  return imagesData;
}