import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

List<LandmarkModel> landmarkModelFromJson(String str) =>
    List<LandmarkModel>.from(
        json.decode(str).map((landmark) => LandmarkModel.fromJson(landmark)));

class LandmarkModel {
  String id;
  LatLng location;
  String name;
  String? imgB64;
  double distance;
  double? rating;
  String? iconUrl;

  LandmarkModel({
    required this.id,
    required this.location,
    required this.name,
    required this.imgB64,
    required this.distance,
    required this.rating,
    required this.iconUrl,
  });

  factory LandmarkModel.fromJson(Map<String, dynamic> json) => LandmarkModel(
        id: json['id'],
        location: LatLng(json['latitude'], json['longitude']),
        name: json['name'],
        imgB64: json['image'],
        distance: json['distance'],
        rating: json['rating'],
        iconUrl: json['iconUrl'],
      );
}
