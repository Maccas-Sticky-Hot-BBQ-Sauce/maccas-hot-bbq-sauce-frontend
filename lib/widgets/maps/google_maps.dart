import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/shape_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/utilities/google_maps_util.dart';

import '../../models/stop_time_model.dart';

class GoogleMapDisplay extends StatefulWidget {
  final LatLng center;
  final Set<Marker>? markers;
  final String? polylineId;
  final List<ShapeModel>? polylineShape;
  final List<StopTimeModel>? stopTimes;
  final double? zoomLevel;

  const GoogleMapDisplay({
    Key? key,
    required this.center,
    this.markers,
    this.polylineShape,
    this.polylineId,
    this.stopTimes,
    this.zoomLevel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => GoogleMapDisplayState();
}

class GoogleMapDisplayState extends State<GoogleMapDisplay> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    LatLng center = widget.center;
    Set<Marker>? markers = widget.markers;
    String? polylineId = widget.polylineId;
    List<ShapeModel>? polylineShape = widget.polylineShape;
    List<StopTimeModel>? stopTimes = widget.stopTimes;
    double? zoomLevel = widget.zoomLevel;
    double zoom =
        (polylineShape != null) ? GoogleMapsUtil.zoom(polylineShape) : 18.0;

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 40),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Column(
          children: [
            Expanded(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: center,
                  zoom: (zoomLevel != null) ? zoomLevel : zoom,
                ),
                markers: (markers != null) ? markers : {},
                circles: (stopTimes != null)
                    ? GoogleMapsUtil.circleLoc(stopTimes, zoom)
                    : {},
                polylines: (polylineShape != null)
                    ? <Polyline>{
                        Polyline(
                          polylineId: PolylineId(polylineId!),
                          points: GoogleMapsUtil.polylinePoints(polylineShape),
                          width: 5,
                          color: Colors.blue,
                        )
                      }
                    : {},
                zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
