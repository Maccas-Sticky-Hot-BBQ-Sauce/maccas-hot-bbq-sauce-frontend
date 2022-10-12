import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShapeModel {
  int sequence;
  LatLng location;

  ShapeModel({required this.sequence, required this.location});

  factory ShapeModel.fromJson(Map<String, dynamic> json) => ShapeModel(
      sequence: json["sequence"],
      location: LatLng(json["latitude"], json["longitude"]));
}
