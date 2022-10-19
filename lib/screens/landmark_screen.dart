import 'dart:typed_data';

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
  Set<Marker> markers = {};
  late Uint8List dataBytes;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    LandmarkModel landmark = widget.landmark;
    LatLng center = widget.center;

    super.initState();

    markers.add(Marker(
      markerId: MarkerId(landmark.id),
      position: landmark.location,
      infoWindow: InfoWindow(title: landmark.name),
    ));

    markers.add(Marker(
        markerId: const MarkerId("1"),
        position: center,
        infoWindow: const InfoWindow(title: "You are here", anchor: Offset(0.5, 0.5))
    ));
  }


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
            markers: markers,
            zoomLevel: 16,
          ),
          Landmark(
            landmark: landmark,
          ),
        ],
      ),
    );
  }
}
