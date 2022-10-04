import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maccas_sticky_hot_bbq_sauce/constants/api_constants.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_model.dart';

class ApiService {
  // Future<StopModel?> getStopData() async {
  static Future getStopData(String stopId) async {
    try {
      Uri url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.stopsEndpoint + '?id=' + stopId);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print(json.decode(response.body));
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
