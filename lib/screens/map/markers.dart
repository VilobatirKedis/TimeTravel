import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart' as latLng;

class MonumentsData {
  final int monuments_id;
  final String monuments_real_name;
  final String monuments_it_name;
  final String monuments_it_description;
  final String

  MonumentsData(this.name, this.email);

  MonumentsData.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}