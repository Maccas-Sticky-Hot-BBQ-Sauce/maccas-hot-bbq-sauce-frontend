import 'package:flutter/material.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_time_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/screens/trip_screen.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/buttons/route_button.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/cards/bus_card.dart';


class Timetable extends StatefulWidget {
  const Timetable({Key? key, required this.stop}) : super(key: key);

  final StopModel stop;

  @override
  State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    StopModel stop = widget.stop;

    return SingleChildScrollView(
      child: Container(
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
                    stop.name,
                    style: const TextStyle(
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
            for (StopTimeModel stopTime in stop.stopTimes) ...[
              BusCard(
                busNumber: stopTime.trip!.route.shortName,
                busStop: stopTime.trip!.headsign,
                routeColor: stopTime.trip!.route.routeColor,
                platform: "",
                time: stopTime.arrival,
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => TripScreen(tripId: stopTime.trip!.tripId),
                  ));
                },
              ),
            ],
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
    );
  }
}
