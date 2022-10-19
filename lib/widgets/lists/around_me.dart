import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/landmark_model.dart';
import 'package:maccas_sticky_hot_bbq_sauce/screens/landmark_screen.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/cards/landmark_card.dart';

class AroundMe extends StatefulWidget {
  final List<LandmarkModel> landmarks;
  final LatLng center;

  const AroundMe({super.key, required this.landmarks, required this.center});

  @override
  State<AroundMe> createState() => _AroundMeState();
}

class _AroundMeState extends State<AroundMe> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    List<LandmarkModel> landmarks = widget.landmarks;
    LatLng center = widget.center;
    return Column(
      children: <Widget>[
        if (landmarks.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  index >= 3 ? index -= 3 : index = 0;
                  setState(() {});
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
              name: landmarks[i].name,
              distance: landmarks[i].distance,
              image: landmarks[i].imgB64,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LandmarkScreen(
                              landmark: landmarks[i],
                              center: center,
                            )));
              },
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                onTap: () {
                  index + 3 < landmarks.length - 3
                      ? index += 3
                      : index = landmarks.length - 3;
                  setState(() {});
                },
                child: const Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: 100.0,
                ),
              ),
            ],
          ),
        ] else
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                child: const Text('Sorry, no more buses for today!',
                    style: TextStyle(
                      fontFamily: 'helvetica-neue',
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                    )),
              ),
            ],
          )
      ],
    );
  }
}
