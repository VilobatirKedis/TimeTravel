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

Future<Uint8List> getImageOfMonument(int monumentID) async {
  final storageRef = FirebaseStorage.instance.ref();

  Uint8List imageData = Uint8List(0);

  await storageRef
    .child(monumentID.toString() + "_main.jpg")
    .getData(100000000)
    .then((value) => {imageData = value!})
    .catchError((error) => {print(error.toString())});

  return imageData;
}