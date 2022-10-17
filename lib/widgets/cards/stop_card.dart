import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StopCard extends StatelessWidget {
  final String stopName;
  final DateTime stoppingTime;
  final Color? textColor;

  const StopCard({
    Key? key,
    required this.stopName,
    required this.stoppingTime,
    this.textColor
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 35, 0, 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                stopName,
                style: TextStyle(
                  fontFamily: 'helvetica-neue',
                  fontWeight: FontWeight.w300,
                  fontSize: 32,
                  color: (textColor != null) ? textColor : Colors.black,
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
                        style: TextStyle(
                          fontFamily: 'helvetica-neue',
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: (textColor != null) ? textColor : Colors.black,
                          ),
                        )
                    )
                  ],
          ),
        ],
      ),
    );
  }
}