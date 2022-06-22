import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latLng;

class MonumentsData {
  final int id;
  final String real_name;
  /*final String it_name;
  final String it_description;
  //final String en_description;
  final int number_of_votes;
  final int votes_sum;
  final int fk_city_id;*/
  final double latitude;
  final double longitude;

  MonumentsData(this.id, this.real_name/*, this.it_name, 
  this.it_description, this.number_of_votes, this.votes_sum, this.fk_city_id*/,
  this.latitude, this.longitude);

  MonumentsData.fromJson(Map<String, dynamic> json)
      : id = json['monuments_id'],
        real_name = json['monuments_real_name'],
        latitude = json['latitude'],
        longitude = json['longitude'];

  Map<String, dynamic> toJson() => {
        'monuments_id': id,
        'monuments_real_name': real_name,
        'latitude': latitude,
        'longitude': longitude
      };
}