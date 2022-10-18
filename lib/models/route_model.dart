import 'dart:convert';

class RouteModel {
  String routeId;
  String shortName;
  String longName;
  String description;
  String routeType;
  String routeUrl;
  String routeColor;
  String textColor;

  RouteModel({
    required this.routeId,
    required this.shortName,
    required this.longName,
    required this.description,
    required this.routeType,
    required this.routeUrl,
    required this.routeColor,
    required this.textColor,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) => RouteModel(
        routeId: json['id'],
        shortName: json['shortName'],
        longName: json['longName'],
        description: json['description'],
        routeType: json['routeType'],
        routeUrl: json['routeUrl'],
        routeColor: json['routeColor'],
        textColor: json['textColor'],
      );
}
