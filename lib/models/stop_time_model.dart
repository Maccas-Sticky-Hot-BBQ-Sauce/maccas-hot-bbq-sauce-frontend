import 'dart:convert';

import 'package:maccas_sticky_hot_bbq_sauce/models/stop_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/trip_model.dart';

class StopTimeModel {
  String id;
  DateTime arrival;
  DateTime departure;
  int sequence;
  String pickupType;
  String dropOffType;
  TripModel? trip;
  StopModel? stop;

  StopTimeModel(
      {required this.id,
      required this.arrival,
      required this.departure,
      required this.sequence,
      required this.pickupType,
      required this.dropOffType,
      required this.trip,
      required this.stop});

  factory StopTimeModel.fromJson(Map<String, dynamic> json) {
    DateTime now = DateTime.now();
    List<String> arrivalSplit = json['arrival'].split(":");
    List<String> departureSplit = json['departure'].split(":");

    return StopTimeModel(
        id: json["id"],
        arrival: DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(arrivalSplit[0]),
            int.parse(arrivalSplit[1]),
            int.parse(arrivalSplit[2])),
        departure: DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(departureSplit[0]),
            int.parse(departureSplit[1]),
            int.parse(departureSplit[2])),
        sequence: json["sequence"],
        pickupType: json["pickupType"],
        dropOffType: json["dropOffType"],
        trip: json['trip'] != null ? TripModel.fromJson(json["trip"]) : null,
        stop: json['stop'] != null ? StopModel.fromJson(json['stop']) : null);
  }
}
