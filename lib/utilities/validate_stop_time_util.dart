import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/calendar_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/exception_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_time_model.dart';

class ValidateStopTimeUtil {
  static DateTime now = DateTime.now().subtract(Duration(days: 5));

  static bool valid(StopTimeModel stopTime) {
    for (ExceptionModel exception in stopTime.trip!.exceptions ?? []) {
      if (DateUtils.isSameDay(exception.date, now)) {
        return false;
      }
    }
    if (runningToday(stopTime.trip!.calendar)) {
      return afterNow(stopTime);
    } else {
      return false;
    }
  }

  static bool runningToday(CalendarModel calendar) {
    String today = DateFormat('EEEE').format(now).toUpperCase();
    if (!calendar.days.contains(today)) {
      return false;
    } else if (calendar.startDate.isAfter(now) ||
        calendar.endDate.isBefore(now)) {
      return false;
    } else {
      return true;
    }
  }

  static bool afterNow(StopTimeModel stopTime) {
    return stopTime.departure.isAfter(now) ? true : false;
  }
}
