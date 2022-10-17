import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BusCard extends StatelessWidget {
  final String busNumber;
  final String busStop;
  final String routeColor;
  final String platform;
  final DateTime time;
  final GestureTapCallback onTap;

  const BusCard(
      {Key? key,
      required this.busNumber,
      required this.busStop,
      required this.routeColor,
      required this.platform,
      required this.time,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int routeColorInt = int.parse('0xFF$routeColor');
    String formattedTime = DateFormat('kk:mm').format(time);
    String remainingTime = getDuration(time.difference(DateTime.now()));

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 127,
                  height: 86,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(routeColorInt),
                  ),
                  child: Text(
                    busNumber,
                    style: const TextStyle(
                      fontFamily: 'helvetica-neue',
                      fontWeight: FontWeight.w700,
                      fontSize: 44,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        busStop,
                        style: const TextStyle(
                          fontFamily: 'helvetica-neue',
                          fontWeight: FontWeight.w500,
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        platform,
                        style: const TextStyle(
                            fontFamily: 'helvetica-neue',
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                            color: Color(0xFF666666)),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  constraints: const BoxConstraints.tightForFinite(
                      width: 149, height: 98),
                  margin: const EdgeInsets.fromLTRB(0, 0, 32.27, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        formattedTime,
                        style: const TextStyle(
                          fontFamily: 'helvetica-neue',
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        remainingTime,
                        style: const TextStyle(
                            fontFamily: 'helvetica-neue',
                            fontWeight: FontWeight.w400,
                            fontSize: 30,
                            color: Color(0xFF666666)),
                      )
                    ],
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_right_sharp,
                  size: 50.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String getDuration(Duration duration) {
    String twoDigits(int n) => n.toString();
    String twoDigitMinutes = twoDigits(duration.inMinutes);
    if (duration.inMinutes == 0) {
      return "Arriving";
    } else if (duration.inMinutes < 0) {
      return "Departed";
    } else {
      return "$twoDigitMinutes Mins";
    }
  }
}
