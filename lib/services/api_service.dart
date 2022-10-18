import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:maccas_sticky_hot_bbq_sauce/constants/api_constants.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/landmark_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/trip_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/utilities/time_util.dart';

class ApiService {
  static Future<StopModel?> getStopData(String stopId) async {
    DateTime now = DateTime.now();

    String fromTime =
        '${TimeUtil.getZeroPaddedDigit(now.hour)}:${TimeUtil.getZeroPaddedDigit(now.minute)}:${TimeUtil.getZeroPaddedDigit(now.second)}';
    String toTime =
        '${TimeUtil.getZeroPaddedDigit(now.hour + 5)}:${TimeUtil.getZeroPaddedDigit(now.minute)}:${TimeUtil.getZeroPaddedDigit(now.second)}';

    try {
      Uri url = Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.filteredStopsEndpoint}?id=$stopId&fromTime=$fromTime&toTime=$toTime');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        StopModel model = stopModelFromJson(response.body);
        return model;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<TripModel?> getStopTimesFromTrip(String tripId) async {
    try {
      Uri url = Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.tripsEndpoint}?id=$tripId');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        TripModel model = tripModelFromJson(response.body);
        return model;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<List<LandmarkModel>> getLandmarksFromStop(String stopId) async {
    try {
      Uri url = Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.landmarksEndpoint}?stopId=$stopId');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<LandmarkModel> model = landmarkModelFromJson(response.body);
        return model;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
