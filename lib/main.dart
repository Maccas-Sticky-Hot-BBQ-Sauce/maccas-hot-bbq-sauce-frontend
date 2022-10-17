import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:maccas_sticky_hot_bbq_sauce/constants/api_constants.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/landmark_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/trip_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/appbar/appbar.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/lists/around_me.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/lists/timetable.dart';
import 'package:maccas_sticky_hot_bbq_sauce/utilities/time_util.dart';
import 'package:maccas_sticky_hot_bbq_sauce/services/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/maps/google_maps.dart';

Future main() async {
  await dotenv.load(fileName: 'constants.env');
  ApiService.getStopData(ApiConstants.currentStopId);
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
  StopModel? currentStop;
  TripModel? trip;
  String displayState = 'TIMETABLE';
  List<LandmarkModel> landmarks = [];

  @override
  void initState() {
    _time = TimeUtil.formatDateTime(DateTime.now());
    Timer.periodic(
        const Duration(seconds: 1),
        (Timer t) => setState(() {
              _time = TimeUtil.getTime(_time);
            }));
    super.initState();
    _getData();
  }

  void _getData() async {
    currentStop = (await ApiService.getStopData(ApiConstants.currentStopId))!;
    inspect(currentStop);
    landmarks =
        await ApiService.getLandmarksFromStop(ApiConstants.currentStopId);
    inspect(landmarks);
  }

  void setDisplayState(String newState) {
    displayState = newState;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          time: _time,
          appBar: AppBar(),
        ),
        body: ListView(children: [
          if (currentStop != null) ...[
            GoogleMapDisplay(
                center: currentStop!.location, markerId: currentStop!.name),
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
                    GestureDetector(
                      onTap: () {
                        setDisplayState('TIMETABLE');
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                        child: displayState == 'TIMETABLE'
                            ? const Text(
                                'Timetable',
                                style: TextStyle(
                                    fontFamily: 'helvetica-neue',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 44,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Color(0xFFF6DB00),
                                    color: Color(0xFF1B4B87)),
                              )
                            : const Text(
                                'Timetable',
                                style: TextStyle(
                                    fontFamily: 'helvetica-neue',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 40,
                                    color: Color(0xFF666666)),
                              ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setDisplayState('AROUND_ME');
                      },
                      child: displayState == 'AROUND_ME'
                          ? const Text(
                              'Around Me',
                              style: TextStyle(
                                  fontFamily: 'helvetica-neue',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 44,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xFFF6DB00),
                                  color: Color(0xFF1B4B87)),
                            )
                          : const Text(
                              'Around Me',
                              style: TextStyle(
                                  fontFamily: 'helvetica-neue',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 40,
                                  color: Color(0xFF666666)),
                            ),
                    ),
                  ]),
                  displayState == 'TIMETABLE'
                      ? Timetable(stop: currentStop!)
                      : AroundMe(landmarks: landmarks),
                ],
              ),
            ),
          ]
        ]));
  }
}
