import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maccas_sticky_hot_bbq_sauce/constants/api_constants.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/landmark_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/trip_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/screens/around_me_screen.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/appbar/appbar_stateful.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/lists/timetable.dart';
import 'package:maccas_sticky_hot_bbq_sauce/services/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/maps/google_maps.dart';

Future main() async {
  await dotenv.load(fileName: 'constants.env');

  String? stopId = Uri.base.queryParameters['stopId'];

  runApp(MyApp(stopId: stopId));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.stopId}) : super(key: key);

  final String? stopId;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QLDBus',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'QLD Bus Stop Explorer', stopId: stopId),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.stopId})
      : super(key: key);

  final String title;
  final String? stopId;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StopModel? currentStop;
  TripModel? trip;
  String displayState = 'TIMETABLE';
  List<LandmarkModel> landmarks = [];

  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData() async {
    currentStop = (await ApiService.getStopData(
        widget.stopId ?? ApiConstants.currentStopId))!;
    landmarks = await ApiService.getLandmarksFromStop(
        widget.stopId ?? ApiConstants.currentStopId);
    inspect(currentStop);
    inspect(landmarks);
    setState(() {});
  }

  void setDisplayState(String newState) {
    setState(() {
      displayState = newState;
    });
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = (currentStop != null)
        ? <Marker>{
            Marker(
              markerId: const MarkerId("1"),
              position: currentStop!.location,
            )
          }
        : {};
    return Scaffold(
        appBar: const AppBarStateful(),
        body: ListView(children: [
          if (currentStop != null) ...[
            GoogleMapDisplay(
              center: currentStop!.location,
              markers: markers,
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
                          currentStop!.name,
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
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                        child: const Text(
                                'Timetable',
                                style: TextStyle(
                                    fontFamily: 'helvetica-neue',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 44,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFFF6DB00),
                                    color: Color(0xFF1B4B87)),
                              )
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AroundMeScreen(
                            landmarks: landmarks,
                            center: currentStop!.location,
                            stopName: currentStop!.name,
                        )));
                      },
                      child: const Text(
                              'Around Me',
                              style: TextStyle(
                                  fontFamily: 'helvetica-neue',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 40,
                                  color: Color(0xFF666666)),
                            ),
                    ),
                  ]),
                  Timetable(stop: currentStop!),
                ],
              ),
            ),
          ]
        ]));
  }
}
