import 'package:flutter/material.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_time_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/trip_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/cards/bus_card.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/cards/stop_card.dart';

class RouteStops extends StatefulWidget {
  final TripModel trip;
  final StopTimeModel stopTime;
  final String? platform;
  const RouteStops(
      {Key? key, required this.trip, required this.stopTime, this.platform})
      : super(key: key);

  @override
  State<RouteStops> createState() => _RouteStopsState();
}

class _RouteStopsState extends State<RouteStops> {
  @override
  Widget build(BuildContext context) {
    TripModel trip = widget.trip;
    StopTimeModel stopTime = widget.stopTime;
    String? platform = widget.platform;
    int currentStopIndex = getIndex(trip);
    int index = currentStopIndex - (currentStopIndex % 5);
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
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          size: 64,
                        )),
                  ),
                  const Text(
                    "Details",
                    style: TextStyle(
                        fontFamily: 'helvetica-neue',
                        fontWeight: FontWeight.w500,
                        fontSize: 44),
                  )
                ],
              ),
            ),
            BusCard(
                busNumber: stopTime.trip!.route.shortName,
                busStop: stopTime.trip!.headsign,
                routeColor: stopTime.trip!.route.routeColor,
                platform: platform ?? "",
                time: stopTime.arrival,
                onTap: () {}),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 48.53, 70),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      index < 5 ? index = 0 : index -= 5;
                    },
                    child: Icon(
                      Icons.keyboard_arrow_up_sharp,
                      size: 100.0,
                      color: index - 5 < 0
                          ? const Color(0xFF8C8C8C)
                          : const Color(0xFF222222),
                    ),
                  )
                ],
              ),
            ),
            for (int i = index; i < index + 5; i++)
              StopCard(
                  stopName: trip.stopTimes![i].stop!.name,
                  stoppingTime: trip.stopTimes![i].arrival),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 48.53, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      index + 5 > trip.stopTimes!.length - 5
                          ? index = trip.stopTimes!.length - 5
                          : index += 5;
                    },
                    child: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 100.0,
                      color: index + 5 > trip.stopTimes!.length - 1
                          ? const Color(0xFF8C8C8C)
                          : const Color(0xFF222222),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static int getIndex(TripModel trip) {
    return trip.stopTimes!
        .indexWhere((stopTime) => stopTime.trip!.id == trip.id);
  }
}
