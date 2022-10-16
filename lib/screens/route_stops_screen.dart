import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_time_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/utilities/time_util.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/lists/route_stops.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/maps/google_maps.dart';

import '../widgets/appbar/appbar.dart';

class RouteStopsScreen extends StatefulWidget {

  const RouteStopsScreen({Key? key, required this.stopTime}) : super(key: key);

  final StopTimeModel stopTime;

  @override
  State<StatefulWidget> createState() => RouteStopsScreenState();
}

class RouteStopsScreenState extends State<RouteStopsScreen> {
  late String _time;

  @override
  void initState() {
    _time = TimeUtil.formatDateTime(DateTime.now());
    Timer.periodic(
        const Duration(seconds: 1),
            (Timer t) => setState(() {
          _time = TimeUtil.getTime(_time);
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final StopTimeModel stopTime = widget.stopTime;
    return Scaffold(
        appBar: AppBarWidget(
          time: _time,
          appBar: AppBar(),
        ),
        body: ListView(children: [
          // GoogleMapDisplay(center: , markerId: ),
          RouteStops(trip: stopTime.trip),
        ]));
  }
}
