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
  String routeFilterId = "";

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

    return Column(
      children: <Widget>[
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
                  routeFilterId = "";
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
              ...[
                for (int i = 0; i < 1; i++)
                  RouteButton(
                      text: stop.routes[stop.routes.keys.toList()[i]]!,
                      onPressed: () =>
                          routeFilterId = stop.routes.keys.toList()[i])
              ],
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
                  InkWell(
                    onTap: () {
                      index >= 5 ? index -= 5 : index = 0;
                      print(index);
                    },
                    child: const Icon(
                      Icons.keyboard_arrow_up_sharp,
                      size: 100.0,
                    ),
                  ),
                  for (int i = index;
                      i < index + 5 && i < stop.stopTimes.length;
                      i++)
                    if (routeFilterId == "" ||
                        routeFilterId == stop.stopTimes[i].trip!.route.routeId)
                      BusCard(
                        busNumber: stop.stopTimes[i].trip!.route.shortName,
                        busStop: stop.stopTimes[i].trip!.headsign,
                        routeColor: stop.stopTimes[i].trip!.route.routeColor,
                        platform: (stop.platformCode != null)
                            ? stop.platformCode!
                            : '',
                        time: stop.stopTimes[i].arrival,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TripScreen(
                                  tripId: stop.stopTimes[i].trip!.tripId,
                                  platform: stop.platformCode,
                                  stopTime: stop.stopTimes[i],
                                  stopId: stop.id,
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
                ],
              ),
            ),
        ] else
          const Text('tai')
      ],
    );
  }
}
