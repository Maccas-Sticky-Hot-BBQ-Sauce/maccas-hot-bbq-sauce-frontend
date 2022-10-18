import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_time_model.dart';

import '../models/shape_model.dart';

class GoogleMapsUtil {
  static int parseRoute (String routeName) {
    if (routeName.length > 3) {
      return int.parse(routeName.substring(1));
    } else {
      return int.parse(routeName);
    }
  }

  static List<LatLng> polylinePoints (List<ShapeModel> shapes){
    List<LatLng> toReturn = [];
    for (ShapeModel shape in shapes) {
      toReturn.add(shape.location);
    }
    return toReturn;
  }

  static double zoom (List<ShapeModel> shapes){
    LatLngBounds toCompute = computeBounds(polylinePoints(shapes));
    return getBoundsZoomLevel(toCompute, const Size(1600, 900)) + 1.8;
  }

  static LatLng getCenter (List<ShapeModel> shapes){
    return getCenterLatLng(polylinePoints(shapes));
  }

  static LatLngBounds computeBounds(List<LatLng> list) {
    assert(list.isNotEmpty);
    var firstLatLng = list.first;
    var s = firstLatLng.latitude,
        n = firstLatLng.latitude,
        w = firstLatLng.longitude,
        e = firstLatLng.longitude;
    for (var i = 1; i < list.length; i++) {
      var latlng = list[i];
      s = min(s, latlng.latitude);
      n = max(n, latlng.latitude);
      w = min(w, latlng.longitude);
      e = max(e, latlng.longitude);
    }
    return LatLngBounds(southwest: LatLng(s, w), northeast: LatLng(n, e));
  }

  static double getBoundsZoomLevel(LatLngBounds bounds, Size mapDimensions) {
    var worldDimension = const Size(1024, 1024);

    double latRad(lat) {
      var sinValue = sin(lat * pi / 180);
      var radX2 = log((1 + sinValue) / (1 - sinValue)) / 2;
      return max(min(radX2, pi), -pi) / 2;
    }

    double zoom(mapPx, worldPx, fraction) {
      return (log(mapPx / worldPx / fraction) / ln2).floorToDouble();
    }

    var ne = bounds.northeast;
    var sw = bounds.southwest;

    var latFraction = (latRad(ne.latitude) - latRad(sw.latitude)) / pi;

    var lngDiff = ne.longitude - sw.longitude;
    var lngFraction = ((lngDiff < 0) ? (lngDiff + 360) : lngDiff) / 360;

    var latZoom = zoom(mapDimensions.height, worldDimension.height, latFraction);
    var lngZoom = zoom(mapDimensions.width, worldDimension.width, lngFraction);

    if (latZoom < 0) return lngZoom;
    if (lngZoom < 0) return latZoom;

    return min(latZoom, lngZoom);
  }

  static LatLng getCenterLatLng(List<LatLng> geoCoordinates) {
    if (geoCoordinates.length == 1) {
      return geoCoordinates.first;
    }

    double x = 0;
    double y = 0;
    double z = 0;

    for (var geoCoordinate in geoCoordinates) {
      var latitude = geoCoordinate.latitude * pi / 180;
      var longitude = geoCoordinate.longitude * pi / 180;

      x += cos(latitude) * cos(longitude);
      y += cos(latitude) * sin(longitude);
      z += sin(latitude);
    }

    var total = geoCoordinates.length;

    x = x / total;
    y = y / total;
    z = z / total;

    var centralLongitude = atan2(y, x);
    var centralSquareRoot = sqrt(x * x + y * y);
    var centralLatitude = atan2(z, centralSquareRoot);

    return LatLng(centralLatitude * 180 / pi, centralLongitude * 180 / pi);
  }

  static Set<Circle> circleLoc (List<StopTimeModel> stopTimes, double zoom){
    Set<Circle> toReturn = {};
    for (StopTimeModel stopTime in stopTimes){
      toReturn.add(
          Circle(
            circleId: CircleId(stopTime.stop!.name),
            center: stopTime.stop!.location,
            radius: 1500 / zoom,
            fillColor: Colors.white,
            strokeWidth: 1,
      ));
    }
    return toReturn;
  }
}