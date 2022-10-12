import 'dart:convert';

class ExceptionModel {
  DateTime date;
  String exceptionType;

  ExceptionModel({
    required this.date,
    required this.exceptionType,
  });

  factory ExceptionModel.fromJson(Map<String, dynamic> json) => ExceptionModel(
        date: DateTime.parse(json['date']),
        exceptionType: json["exceptionType"],
      );
}
