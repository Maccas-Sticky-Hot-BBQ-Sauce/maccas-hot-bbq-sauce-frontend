import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_time_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/utilities/time_util.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/lists/route_stops.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/maps/google_maps.dart';

import '../models/trip_model.dart';
import '../services/api_service.dart';
import '../widgets/appbar/appbar.dart';

class TripScreen extends StatefulWidget {
  const TripScreen(
      {Key? key,
      required this.tripId,
      this.platform,
      required this.stopTime,
      required this.stopId})
      : super(key: key);

  final String tripId;
  final String? platform;
  final StopTimeModel stopTime;
  final String stopId;

  @override
  State<StatefulWidget> createState() => TripScreenState();
}

class TripScreenState extends State<TripScreen> {
  late String _time;
  TripModel? trip;

  @override
  void initState() {
    _time = TimeUtil.formatDateTime(DateTime.now());
    Timer.periodic(
        const Duration(seconds: 1),
        (Timer t) => setState(() {
              _time = TimeUtil.getTime(_time);
            }));
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
  }

  @override
  Widget build(BuildContext context) {
    StopTimeModel stopTime = widget.stopTime;
    String? platform = widget.platform;
    String stopId = widget.stopId;
    return Scaffold(
        appBar: AppBarWidget(
          time: _time,
          appBar: AppBar(),
        ),
        body: ListView(children: [
          if (trip != null) ...[
            GoogleMapDisplay(
              center: trip!.stopTimes![0].stop!.location,
              zoom: 10.0,
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
