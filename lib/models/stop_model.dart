import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_time_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/utilities/validate_stop_time_util.dart';

StopModel stopModelFromJson(String str) => StopModel.fromJson(json.decode(str));

class StopModel {
  String id;
  int stopId;
  String stopCode;
  String name;
  String description;
  LatLng location;
  String zoneId;
  String stopUrl;
  int locationType;
  String? platformCode;
  List<StopTimeModel> stopTimes;

  StopModel({
    required this.id,
    required this.stopId,
    required this.stopCode,
    required this.name,
    required this.description,
    required this.location,
    required this.zoneId,
    required this.stopUrl,
    required this.locationType,
    required this.platformCode,
    required this.stopTimes,
  });

  factory StopModel.fromJson(Map<String, dynamic> json) {
    List<StopTimeModel> stopTimeModel = List<StopTimeModel>.from(
        json["stopTimes"].map((stopTime) => StopTimeModel.fromJson(stopTime)));

    List<StopTimeModel> validStopTimes = List<StopTimeModel>.from(stopTimeModel.where((stopTime) => ValidateStopTimeUtil.valid(stopTime)));
    validStopTimes.sort((a, b) => a.departure.compareTo(b.departure));

    // print(validStopTimes);
    return StopModel(
        id: json["id"],
        stopId: int.parse(json["stopId"]),
        stopCode: json["stopCode"],
        name: json["name"],
        description: json["description"],
        location: LatLng(json["latitude"], json["longitude"]),
        zoneId: json["zoneId"],
        stopUrl: json["stopUrl"],
        locationType: json["locationType"],
        platformCode: json["platformCode"],
        stopTimes: validStopTimes);
  }
}

enum Direction { inbound, outbound }
