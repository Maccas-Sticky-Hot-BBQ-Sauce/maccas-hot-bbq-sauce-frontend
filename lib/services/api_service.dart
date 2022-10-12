import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maccas_sticky_hot_bbq_sauce/constants/api_constants.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_model.dart';

class ApiService {
  static Future<StopModel?> getStopData(String stopId) async {
    try {
      Uri url = Uri.parse(
          '${ApiConstants.baseUrl}${ApiConstants.stopsEndpoint}?id=$stopId');
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
}
