import 'package:flutter/material.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/landmark_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/screens/landmark_screen.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/cards/landmark_card.dart';

class AroundMe extends StatefulWidget {
  final List<LandmarkModel> landmarks;

  const AroundMe({super.key, required this.landmarks});

  @override
  State<AroundMe> createState() => _AroundMeState();
}

class _AroundMeState extends State<AroundMe> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    List<LandmarkModel> landmarks = widget.landmarks;
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                index >= 3 ? index -= 3 : index = 0;
              },
              child: const Icon(
                Icons.keyboard_arrow_up_sharp,
                size: 100.0,
              ),
            ),
          ],
        ),
        for (int i = index; i < index + 3; i++)
          LandmarkCard(
            name: 'UQ Biological Science Library',
            distance: 300,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LandmarkScreen(
                            landmark: landmarks[i],
                          )));
            },
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                index + 3 > landmarks.length - 1
                    ? index += 3
                    : index = landmarks.length - 1;
              },
              child: const Icon(
                Icons.keyboard_arrow_down_sharp,
                size: 100.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
