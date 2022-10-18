import 'package:flutter/material.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart' as web;
import 'dart:ui' as ui;
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/shape_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/utilities/google_maps_util.dart';

import '../../models/stop_time_model.dart';

class GoogleMapDisplay extends StatelessWidget {
  final LatLng center;
  final int mapId;
  final String? markerId;
  final String? polylineId;
  final List<ShapeModel>? polylineShape;
  final List<StopTimeModel>? stopTimes;

  const GoogleMapDisplay ({
    Key? key,
    required this.center,
    this.markerId,
    this.polylineShape,
    this.polylineId,
    required this.mapId,
    this.stopTimes,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    double zoom = (polylineShape != null) ? GoogleMapsUtil.zoom(polylineShape!) : 20.0;
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 40),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Column(
          children: [
            Expanded(
              child: web.GoogleMapsPlugin().
              buildViewWithConfiguration(
                  mapId,
                      (id) {},
                  widgetConfiguration:
                  MapWidgetConfiguration(
                    initialCameraPosition:
                      CameraPosition(
                        target: center,
                        zoom: zoom,
                    ),
                    textDirection: ui.TextDirection.ltr,
                  ),
                  mapObjects: MapObjects(
                      markers: (markerId != null) ?
                      <Marker>{
                            Marker(
                              markerId: MarkerId(markerId!),
                              position: center,
                            )
                        }
                        : {},
                      circles: (stopTimes != null) ? GoogleMapsUtil.circleLoc(stopTimes!, zoom) : {},
                      polylines: (polylineShape != null) ?
                      <Polyline>{
                            Polyline(
                              polylineId: PolylineId(polylineId!),
                              points: GoogleMapsUtil.polylinePoints(polylineShape!),
                              width: 5,
                              color: Colors.blue,
                            )
                        }
                        : {},
                  ),
                  mapConfiguration: const MapConfiguration(
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: false,
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
