import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/calendar_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/exception_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_time_model.dart';

class ValidateStopTimeUtil {

  static bool valid(StopTimeModel stopTime){
    for (ExceptionModel exception in stopTime.trip.exceptions ?? []) {
        if (DateUtils.isSameDay(exception.date, DateTime.now())) {
          return false;
        }
    }
    if (runningToday(stopTime.trip.calendar)){
      return afterNow(stopTime);
    } else {
      return false;
    }
  }

  static bool runningToday (CalendarModel calendar){
    String today = DateFormat('EEEE').format(DateTime.now()).toUpperCase();
    if (!calendar.days.contains(today)){
      return false;
    }
    else if (calendar.startDate.isAfter(DateTime.now()) && calendar.endDate.isBefore(DateTime.now())) {
      return false;
    }
    else {
      return true;
    }
  }

  static bool afterNow(StopTimeModel stopTime){
    return stopTime.departure.isAfter(DateTime.now()) ? true : false;
  }
}