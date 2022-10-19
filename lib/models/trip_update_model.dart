import 'dart:convert';

Map<String, TripUpdateModel> tripUpdateModelFromJson(String str) {
  Map<String, TripUpdateModel> map = {};

  json.decode(str).forEach((tripUpdate) {
    TripUpdateModel model = TripUpdateModel.fromJson(tripUpdate);
    map[model.stopTimeId] = model;
  });

  return map;
}

class TripUpdateModel {
  String stopTimeId;

  int arrivalDelay;
  DateTime arrivalTime;
  int arrivalUncertainty;

  int departureDelay;
  DateTime departureTime;
  int departureUncertainty;

  String tripRelationship;
  String scheduleRelationship;

  TripUpdateModel({
    required this.stopTimeId,
    required this.arrivalDelay,
    required this.arrivalTime,
    required this.arrivalUncertainty,
    required this.departureDelay,
    required this.departureTime,
    required this.departureUncertainty,
    required this.tripRelationship,
    required this.scheduleRelationship,
  });

  factory TripUpdateModel.fromJson(Map<String, dynamic> json) {
    DateTime now = DateTime.now();
    List<String> arrivalSplit = json['arrival']['time'].split(":");
    List<String> departureSplit = json['departure']['time'].split(":");

    return TripUpdateModel(
        stopTimeId: json['stopTimeId'],
        arrivalDelay: json['arrival']['delay'],
        arrivalTime: DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(arrivalSplit[0]),
            int.parse(arrivalSplit[1]),
            int.parse(arrivalSplit[2])),
        arrivalUncertainty: json['arrival']['uncertainty'],
        departureDelay: json['departure']['delay'],
        departureTime: DateTime(
            now.year,
            now.month,
            now.day,
            int.parse(departureSplit[0]),
            int.parse(departureSplit[1]),
            int.parse(departureSplit[2])),
        departureUncertainty: json['uncertainty'],
        tripRelationship: json['tripRelationship'],
        scheduleRelationship: json['scheduleRelationship']);
  }
}
