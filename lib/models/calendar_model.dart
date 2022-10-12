import 'dart:convert';

import 'package:flutter/material.dart';

class CalendarModel {
  List<String> days;
  DateTime startDate;
  DateTime endDate;

  CalendarModel({
    required this.days,
    required this.startDate,
    required this.endDate,
  });

  factory CalendarModel.fromJson(Map<String, dynamic> json) => CalendarModel(
      days: List<String>.from(json["days"]),
      startDate: DateTime.parse(json["startDate"]),
      endDate: DateTime.parse(json["endDate"]));
}
