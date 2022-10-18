import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/landmark_model.dart';

import 'package:maccas_sticky_hot_bbq_sauce/widgets/appbar/appbar_stateful.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/lists/landmark.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/maps/google_maps.dart';

class LandmarkScreen extends StatefulWidget {
  const LandmarkScreen({Key? key, required this.landmark, required this.center})
      : super(key: key);

  final LandmarkModel landmark;
  final LatLng center;

  @override
  State<StatefulWidget> createState() => LandmarkScreenState();
}

class LandmarkScreenState extends State<LandmarkScreen> {
  @override
  Widget build(BuildContext context) {
    LatLng center = widget.center;
    LandmarkModel landmark = widget.landmark;
    return Scaffold(
      appBar: const AppBarStateful(),
      body: ListView(
        children: [
          GoogleMapDisplay(
            center: center,
            mapId: 10000,
          ),
          Landmark(
            landmark: landmark,
          ),
        ],
      ),
    );
  }
}
