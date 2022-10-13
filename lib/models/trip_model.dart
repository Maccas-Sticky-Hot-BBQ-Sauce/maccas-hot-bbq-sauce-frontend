import 'dart:convert';

import 'package:maccas_sticky_hot_bbq_sauce/models/calendar_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/exception_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/route_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/shape_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_time_model.dart';

TripModel tripModelFromJson(String str) => TripModel.fromJson(json.decode(str));

class TripModel {
  String id;
  String tripId;
  String serviceId;
  String shapeId;
  String headsign;
  Direction direction;
  String blockId;
  List<ShapeModel> shapes;
  CalendarModel calendar;
  List<ExceptionModel>? exceptions;
  RouteModel route;
  List<StopTimeModel>? stopTimes;

  TripModel({
    required this.id,
    required this.tripId,
    required this.serviceId,
    required this.shapeId,
    required this.headsign,
    required this.direction,
    required this.blockId,
    required this.shapes,
    required this.calendar,
    required this.exceptions,
    required this.route,
    required this.stopTimes,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
        id: json["id"],
        tripId: json["tripId"],
        serviceId: json["serviceId"],
        shapeId: json["shapeId"],
        headsign: json["headsign"],
        direction: Direction.inbound.hashCode ==
                json["direction"].toLowerCase().hashCode
            ? Direction.inbound
            : Direction.outbound,
        blockId: json["blockId"],
        shapes: List<ShapeModel>.from(
            json["shapes"].map((shape) => ShapeModel.fromJson(shape))),
        calendar: CalendarModel.fromJson(json['calendar']),
        exceptions: List<ExceptionModel>.from(json['exceptions'] != null
            ? json['exceptions'].map((exc) => ExceptionModel.fromJson(exc))
            : []),
        route: RouteModel.fromJson(json['route']),
        stopTimes: List<StopTimeModel>.from(json['stopTimes'] != null
            ? json['stopTimes']
                .map((stopTime) => StopTimeModel.fromJson(stopTime))
            : []),
      );
}
