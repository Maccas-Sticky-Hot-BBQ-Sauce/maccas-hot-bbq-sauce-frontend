import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_time_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/trip_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/screens/trip_screen.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/cards/bus_card.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/cards/stop_card.dart';

class RouteStops extends StatefulWidget {
  final TripModel trip;
  final StopTimeModel stopTime;
  final String? platform;
  final int stopId;
  const RouteStops(
      {Key? key,
        required this.trip,
        required this.stopTime,
        this.platform,
        required this.stopId})
      : super(key: key);

  @override
  State<RouteStops> createState() => _RouteStopsState();
}

class _RouteStopsState extends State<RouteStops> {
  int index = 0;
  int currentStopIndex = 0;
  String pressedStop = "";

  @override
  void initState() {
    super.initState();
    currentStopIndex = getIndex(widget.trip, widget.stopId);
    index = currentStopIndex - currentStopIndex % 5;
  }

  @override
  Widget build(BuildContext context) {
    TripModel trip = widget.trip;
    StopTimeModel stopTime = widget.stopTime;
    String? platform = widget.platform;

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
                stoppingTime: trip.stopTimes![i].arrival,
                color: (i < currentStopIndex) ? 0xFF8C8C8C : 0xFF222222,
                pressedStop: pressedStop,
                onTap: () {
                  setState(() {
                    pressedStop = trip.stopTimes![i].stop!.name;
                  });
                  Navigator.pop(context);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) =>
                      TripScreen(
                          tripId: trip.tripId,
                          stopTime: stopTime,
                          stopId: stopTime.stopId,
                          markers: <Marker>{
                            Marker(
                              markerId: MarkerId(trip.stopTimes![i].stop!.name),
                              position: trip.stopTimes![i].stop!.location
                            )
                          },
                      )));
                },
              ),
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

  int getIndex(TripModel trip, int stopId) {
    return trip.stopTimes!
        .indexWhere((stopTime) => stopTime.stop!.stopId == stopId);
  }
}
