import 'dart:async';
import 'package:flutter/material.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_model.dart';
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
  int index = 0;

  @override
  Widget build(BuildContext context) {
    StopModel stop = widget.stop;

    Timer.periodic(const Duration(seconds: 10), (timer) {
      for (int i = index; i < stop.stopTimes.length; i++) {
        if (stop.stopTimes[i].departure.isAfter(DateTime.now())) {
          stop.stopTimes.removeRange(0, i);
          index = 0;
          break;
        }
      }
    });

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
              margin: const EdgeInsets.fromLTRB(0, 40, 0, 60),
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
            if (stop.stopTimes.length - 1 - index > 0) ...[
              if ((stop.stopTimes.length - 1) - index > 5)
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 48.53, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          index >= 5 ? index -= 5 : index = 0;
                        },
                        child: const Icon(
                          Icons.keyboard_arrow_up_sharp,
                          size: 100.0,
                        ),
                      ),
                    ],
                  ),
                ),
              for (int i = index;
                  i < index + 5 && i < stop.stopTimes.length;
                  i++)
                BusCard(
                  busNumber: stop.stopTimes[i].trip!.route.shortName,
                  busStop: stop.stopTimes[i].trip!.headsign,
                  routeColor: stop.stopTimes[i].trip!.route.routeColor,
                  platform:
                      (stop.platformCode != null) ? stop.platformCode! : '',
                  time: stop.stopTimes[i].arrival,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TripScreen(
                            tripId: stop.stopTimes[i].trip!.tripId,
                            platform: stop.platformCode,
                            stopTime: stop.stopTimes[i],
                          ),
                        ));
                  },
                ),
              if ((stop.stopTimes.length - 1) - index > 5)
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 48.53, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          index += 5;
                        },
                        child: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          size: 100.0,
                        ),
                      )
                    ],
                  ),
                )
            ] else
              const Text('tai'),
          ],
        ),
      ),
    );
  }
}
