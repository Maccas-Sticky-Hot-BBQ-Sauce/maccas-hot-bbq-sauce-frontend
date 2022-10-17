import 'package:flutter/material.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/stop_model.dart';

class AroundMe extends StatefulWidget {
  final StopModel stop;

  const AroundMe({super.key, required this.stop});

  @override
  State<AroundMe> createState() => _AroundMeState();
}

class _AroundMeState extends State<AroundMe> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
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
      ],
    );
  }
}
