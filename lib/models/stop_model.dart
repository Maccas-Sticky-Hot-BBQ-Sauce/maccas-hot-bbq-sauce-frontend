// import 'dart:convert';

// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class StopModel {
//   String id;
//   int stopId;
//   String stopCode;
//   String name;
//   String description;
//   LatLng location;
//   String zoneId;
//   String stopUrl;
//   int locationType;
//   String? platformCode;
//   List<StopTime> stopTime;

//   StopModel({
//     required this.id,
//     required this.stopId,
//     required this.stopCode,
//     required this.name,
//     required this.description,
//     required this.location,
//     required this.zoneId,
//     required this.stopUrl,
//     required this.locationType,
//     required this.platformCode,
//     required this.stopTime,
//   });

//   factory StopModel.fromJson(Map<String, dynamic> json) => StopModel(
//       id: json["id"],
//       stopId: int.parse(json["stopId"]),
//       stopCode: json["stopCode"],
//       name: json["name"],
//       description: json["description"],
//       location: LatLng(json["latitude"], json["longitude"]),
//       zoneId: json["zoneId"],
//       stopUrl: json["stopUrl"],
//       locationType: json["locationType"],
//       platformCode: json["platformCode"],
//       stopTime: List<StopTime>.from());
// }

// class StopTime {
//   String id;
//   DateTime arrival;
//   DateTime departure;
//   int sequence;
//   String pickupType;
//   String dropOffType;
// }
