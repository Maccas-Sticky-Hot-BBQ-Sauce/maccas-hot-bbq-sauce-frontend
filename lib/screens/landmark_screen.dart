import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/landmark_model.dart';

import 'package:maccas_sticky_hot_bbq_sauce/utilities/time_util.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/appbar/appbar.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/maps/google_maps.dart';

class LandmarkScreen extends StatefulWidget {
  const LandmarkScreen({Key? key, required this.landmark}) : super(key: key);

  final LandmarkModel landmark;

  @override
  State<StatefulWidget> createState() => LandmarkScreenState();
}

class LandmarkScreenState extends State<LandmarkScreen> {
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
    LandmarkModel landmark = widget.landmark;
    return Scaffold(
      appBar: AppBarWidget(
        time: _time,
        appBar: AppBar(),
      ),
      body: ListView(
        children: [
          GoogleMapDisplay(
            center: landmark.location,
            zoom: 10.0,
          ),
        ],
      ),
    );
  }
}
