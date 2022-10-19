import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/landmark_model.dart';

import '../widgets/appbar/appbar_stateful.dart';
import '../widgets/lists/around_me.dart';
import '../widgets/maps/google_maps.dart';

class AroundMeScreen extends StatefulWidget {
  final List<LandmarkModel> landmarks;
  final LatLng center;
  final String stopName;
  
  const AroundMeScreen({Key? key, required this.landmarks, required this.center, required this.stopName}) : super(key: key);
  
  @override
  State<StatefulWidget> createState() => AroundMeScreenState();
}

class AroundMeScreenState extends State<AroundMeScreen> {
  Set<Marker> landmarkMarkers = {};

  @override
  void initState(){
    super.initState();
    for (LandmarkModel landmark in widget.landmarks){
      landmarkMarkers.add(Marker(markerId: MarkerId(landmark.name), position: landmark.location));
    }
    landmarkMarkers.add(Marker(
        markerId: const MarkerId("You are here"),
        position: widget.center,
        infoWindow: const InfoWindow(title: "You are here", anchor: Offset(0.5, 0.5)
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarStateful(),
        body: ListView(children: [
            GoogleMapDisplay(
              center: widget.center,
              markers: landmarkMarkers,
              zoomLevel: 16.0,
            ),
            Container(
              margin: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                          child: Image.asset(
                            'assets/images/location-icon.png',
                            width: 64,
                            height: 64,
                          ),
                        ),
                        Text(
                          widget.stopName,
                          style: const TextStyle(
                              fontFamily: 'helvetica-neue',
                              fontWeight: FontWeight.w500,
                              fontSize: 44),
                        )
                      ],
                    ),
                  ),
                  Row(children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                        child: const Text(
                          'Timetable',
                          style: TextStyle(
                              fontFamily: 'helvetica-neue',
                              fontWeight: FontWeight.w400,
                              fontSize: 40,
                              color: Color(0xFF666666)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        'Around Me',
                        style: TextStyle(
                            fontFamily: 'helvetica-neue',
                            fontWeight: FontWeight.w700,
                            fontSize: 44,
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFFF6DB00),
                            color: Color(0xFF1B4B87)),
                      )
                    ),
                  ]),
                  AroundMe(
                    landmarks: widget.landmarks,
                    center: widget.center,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}