import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StopCard extends StatelessWidget {
  final String stopName;
  final DateTime stoppingTime;

  const StopCard({Key? key, required this.stopName, required this.stoppingTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                stopName,
                style: const TextStyle(
                  fontFamily: 'helvetica-neue',
                  fontWeight: FontWeight.w300,
                  fontSize: 32,
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 32.27, 0),
                  child: Text(
                    DateFormat.Hm().format(stoppingTime),
                    style: const TextStyle(
                      fontFamily: 'helvetica-neue',
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
