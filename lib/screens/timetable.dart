import 'package:flutter/material.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/buttons/route_button.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/cards/bus_card.dart';

class Timetable extends StatefulWidget {
  final StopModel stopModel;
  const Timetable({Key? key, required this.stopModel}) : super(key: key);

  @override
  State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
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
                    widget.stopModel.name,
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
    );
  }
}
