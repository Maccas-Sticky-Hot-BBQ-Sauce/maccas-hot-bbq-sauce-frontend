import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart' as web;
import 'package:intl/intl.dart';
import 'package:maccas_sticky_hot_bbq_sauce/components/buttons/route_button.dart';
import 'package:maccas_sticky_hot_bbq_sauce/components/cards/bus_card.dart';
import 'package:maccas_sticky_hot_bbq_sauce/components/images/app_logo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QLDBus',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'QLD Bus Stop Explorer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String _time;
  final LatLng _center = const LatLng(-27.4979388928164, 153.01115550580272);
  final MarkerId _markerId = const MarkerId("uq_chancellors_place");

  @override
  void initState() {
    _time = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 600,
        leading: Container(
          margin: const EdgeInsets.fromLTRB(36, 0, 0, 0),
          child: appLogo,
        ),
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 36, 0),
                child: Text(
                  _time,
                  style: const TextStyle(
                      fontFamily: 'helvetica-neue',
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      color: Colors.black),
                ),
              )
            ],
          ),
        ],
        toolbarHeight: 140,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
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
                              initialCameraPosition: CameraPosition(target: _center, zoom: 18.0),
                              textDirection: ui.TextDirection.ltr,
                            ),
                            mapObjects: MapObjects(
                                markers: <Marker>{
                                  Marker(
                                      markerId: _markerId,
                                      position: _center,
                                      infoWindow: const InfoWindow(title: "UQ Chancellors Place")
                                  )
                                }
                            )
                        ),
                      )
                    ],
                  ),
                ),
              ),
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
                    const Text(
                      'UQ Chancellors Place',
                      style: TextStyle(
                          fontFamily: 'helvetica-neue',
                          fontWeight: FontWeight.w500,
                          fontSize: 44),
                    )
                  ],
                ),
              ),

              const Text(
                'Timetable',
                style: TextStyle(
                  fontFamily: 'helvetica-neue',
                  fontWeight: FontWeight.w700,
                  fontSize: 44,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Icon(
                      Icons.keyboard_arrow_left_sharp,
                      size: 100.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        return;
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF1B4B87),
                        onPrimary: const Color(0xFFFFE832),
                        fixedSize: const Size(109, 74),
                      ),
                      child: const Text(
                        'All',
                        style: TextStyle(
                          fontFamily: 'helvetica-neue',
                          fontWeight: FontWeight.w700,
                          fontSize: 36,
                        ),
                      ),
                    ),
                    RouteButton(
                      text: "402",
                      onPressed: () {
                        return;
                      },
                    ),
                    RouteButton(
                      text: "411",
                      onPressed: () {
                        return;
                      },
                    ),
                    RouteButton(
                      text: "412",
                      onPressed: () {
                        return;
                      },
                    ),
                    RouteButton(
                      text: "428",
                      onPressed: () {
                        return;
                      },
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right_sharp,
                      size: 100.0,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 60, 48.53, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.keyboard_arrow_up_sharp,
                      size: 100.0,
                    ),
                  ],
                ),
              ),
              BusCard(
                  busNumber: '402',
                  busStop: 'Toowong',
                  routeColor: '8DC63F',
                  platform: 'Stop B',
                  time: DateTime.now().subtract(const Duration(minutes: 1))),
              BusCard(
                  busNumber: '411',
                  busStop: 'City via Hawken Drive',
                  routeColor: '8DC63F',
                  platform: 'Zone C',
                  time: DateTime.now()),
              BusCard(
                  busNumber: '428',
                  busStop: 'Indooroopilly Shopping Centre',
                  routeColor: '8DC63F',
                  platform: 'Zone A',
                  time: DateTime.now()),
              BusCard(
                  busNumber: '412',
                  busStop: 'City Express',
                  routeColor: '8DC63F',
                  platform: 'Zone D',
                  time: DateTime.now().add(const Duration(minutes: 8))),
              BusCard(
                  busNumber: '402',
                  busStop: 'Toowong',
                  routeColor: '8DC63F',
                  platform: 'Zone B',
                  time: DateTime.now().add(const Duration(minutes: 62))),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 48.53, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 100.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _time = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat.Hm().format(dateTime);
  }
}
