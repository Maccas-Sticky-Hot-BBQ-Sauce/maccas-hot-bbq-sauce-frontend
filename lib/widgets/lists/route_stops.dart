import 'package:flutter/material.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/trip_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/cards/stop_card.dart';

import '../../models/stop_time_model.dart';

class RouteStops extends StatefulWidget {
  final TripModel? trip;
  const RouteStops({Key? key, required this.trip}) : super(key: key);

  @override
  State<RouteStops> createState() => _RouteStopsState();
}

class _RouteStopsState extends State<RouteStops> {

  @override
  Widget build(BuildContext context) {
    TripModel? trip = widget.trip;
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
                        )
                    ),
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
            for (StopTimeModel stopTimes in trip!.stopTimes!) ...[
              StopCard(
                  stopName: stopTimes.stop!.name,
                  stoppingTime: stopTimes.arrival,
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
