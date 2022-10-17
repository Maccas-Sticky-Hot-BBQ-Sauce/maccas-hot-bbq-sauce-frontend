import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart' as web;
import 'dart:ui' as ui;
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/shape_model.dart';

class GoogleMapDisplay extends StatelessWidget {
  final LatLng center;
  final int mapId;
  final String? markerId;
  final String? polylineId;
  final List<ShapeModel>? polylineShape;
  final double? zoom;

  const GoogleMapDisplay ({
    Key? key,
    required this.center,
    this.markerId,
    this.polylineShape,
    this.polylineId,
    this.zoom,
    required this.mapId,
  }) : super(key: key);

  List<LatLng> polylinePoints(){
    List<LatLng> toReturn = [];
    for (ShapeModel shape in polylineShape!){
      toReturn.add(shape.location);
    }
    return toReturn;
  }

  @override
  Widget build(BuildContext context) {
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
                      polylines: (polylineShape != null) ?
                      <Polyline>{
                            Polyline(
                              polylineId: PolylineId(polylineId!),
                              points: polylinePoints(),
                              width: 6,
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
