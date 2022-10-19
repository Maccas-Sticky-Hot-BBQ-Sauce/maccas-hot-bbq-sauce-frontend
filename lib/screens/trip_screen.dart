import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_time_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/utilities/google_maps_util.dart';
import 'package:maccas_sticky_hot_bbq_sauce/utilities/time_util.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/appbar/appbar_stateful.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/lists/route_stops.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/maps/google_maps.dart';

import '../models/stop_time_model.dart';
import '../models/trip_model.dart';
import '../services/api_service.dart';

class TripScreen extends StatefulWidget {
  const TripScreen(
      {Key? key,
      required this.tripId,
      this.platform,
      required this.stopTime,
      required this.stopId,
      this.markers,
      this.pressedStop})
      : super(key: key);

  final String tripId;
  final String? platform;
  final StopTimeModel stopTime;
  final int stopId;
  final Set<Marker>? markers;
  final String? pressedStop;

  @override
  State<StatefulWidget> createState() => TripScreenState();
}

class TripScreenState extends State<TripScreen> {
  TripModel? trip;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _getData() async {
    String tripId = widget.tripId;
    trip = (await ApiService.getStopTimesFromTrip(tripId));
    inspect(trip);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    StopTimeModel stopTime = widget.stopTime;
    String? platform = widget.platform;
    int stopId = widget.stopId;
    Set<Marker>? markers = widget.markers;

    return Scaffold(
        appBar: const AppBarStateful(),
        body: ListView(children: [
          if (trip != null) ...[
            GoogleMapDisplay(
              center: GoogleMapsUtil.getCenter(trip!.shapes!),
              polylineId: trip!.route.routeId,
              polylineShape: trip!.shapes,
              markers: (markers != null) ? markers : {},
              stopTimes: trip!.stopTimes,
            ),
            RouteStops(
              trip: trip!,
              stopTime: stopTime,
              platform: platform,
              stopId: stopId,
            ),
          ]
        ]));
  }
}
