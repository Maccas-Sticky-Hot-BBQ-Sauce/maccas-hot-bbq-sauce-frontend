import 'package:flutter/material.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart' as web;
import 'dart:ui' as ui;
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

class GoogleMapDisplay extends StatelessWidget {
  final LatLng center;
  final String markerId;
  const GoogleMapDisplay ({Key? key, required this.center, required this.markerId}) : super(key: key);

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
                    initialCameraPosition: CameraPosition(target: center, zoom: 20.0),
                    textDirection: ui.TextDirection.ltr,
                  ),
                  mapObjects: MapObjects(
                      markers: <Marker>{
                        Marker(
                            markerId: MarkerId(markerId),
                            position: center,
                            infoWindow: const InfoWindow(title: "UQ Chancellors Place")
                        )
                      },
                    polylines: <Polyline>{
                        const Polyline(
                          polylineId: PolylineId("402"),
                          points: [
                            LatLng(-27.563359,153.080421),
                            LatLng(-27.564184,153.081192),
                          ],
                          width: 8,
                          color: Colors.lightGreen,
                        )
                    }
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