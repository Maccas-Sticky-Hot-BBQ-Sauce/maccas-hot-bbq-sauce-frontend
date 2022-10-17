import 'package:flutter/material.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart' as web;
import 'dart:ui' as ui;
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

class GoogleMapDisplay extends StatelessWidget {
  final LatLng center;
  final String? markerId;
  final String? polylineId;
  final List<LatLng>? polylinePoints;
  final double? zoom;

  const GoogleMapDisplay ({
    Key? key,
    required this.center,
    this.markerId,
    this.polylinePoints,
    this.polylineId,
    this.zoom
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 40),
      child: AspectRatio(
        aspectRatio: 16/9,
        child: Column(
          children: [
            Expanded(
              child: web.GoogleMapsPlugin().buildViewWithConfiguration(
                  1, (id) {},
                  widgetConfiguration:
                  MapWidgetConfiguration(
                    initialCameraPosition: CameraPosition(
                        target: center, zoom: (zoom != null) ? zoom! : 20.0),
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
                      polylines: (polylinePoints != null) ?
                      <Polyline>{
                            Polyline(
                              polylineId: PolylineId(polylineId!),
                              points: polylinePoints!,
                              width: 8,
                              color: Colors.lightGreen,
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