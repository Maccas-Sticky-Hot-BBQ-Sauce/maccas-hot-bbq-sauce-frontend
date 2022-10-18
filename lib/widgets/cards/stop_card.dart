import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StopCard extends StatefulWidget {
  final String stopName;
  final DateTime stoppingTime;
  final int color;
  final GestureTapCallback onTap;
  final String pressedStop;

  const StopCard(
      {Key? key,
        required this.stopName,
        required this.stoppingTime,
        required this.color,
        required this.onTap,
        required this.pressedStop})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => StopCardState();
}

class StopCardState extends State<StopCard>{

  @override
  Widget build(BuildContext context) {
    String stopName = widget.stopName;
    DateTime stoppingTime = widget.stoppingTime;
    String pressedStop = widget.pressedStop;
    GestureTapCallback onTap = widget.onTap;
    Color color = (pressedStop != stopName) ? Color(widget.color) : const Color(0xFF2464B4);

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 70),
      child:
      GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(stopName,
                    style: TextStyle(
                        fontFamily: 'helvetica-neue',
                        fontWeight: FontWeight.w300,
                        fontSize: 32,
                        color: color,
                    ))
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 32.27, 0),
                    child: Text(
                      DateFormat.Hm().format(stoppingTime),
                      style: TextStyle(
                        fontFamily: 'helvetica-neue',
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: color,
                      ),
                    ))
              ],
            ),
          ],
        ),
    ),
    );
  }
}