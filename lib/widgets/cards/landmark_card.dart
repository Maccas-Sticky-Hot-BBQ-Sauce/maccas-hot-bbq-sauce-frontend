import 'package:flutter/material.dart';

class LandmarkCard extends StatelessWidget {
  final String name;
  final double distance;
  final String? image;
  final GestureTapCallback onTap;

  const LandmarkCard(
      {Key? key,
      required this.name,
      required this.distance,
      this.image,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 1016,
        height: 210,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 32),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 24, 0),
              child: const Image(
                image: ExactAssetImage("assets/images/no-photo.jpg"),
                height: 210,
                width: 210,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 192, 0),
              child: Text(
                name,
                style: const TextStyle(
                    fontFamily: 'helvetica-neue',
                    fontWeight: FontWeight.w400,
                    fontSize: 36),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(
                '$distance m',
                style: const TextStyle(
                    fontFamily: 'helvetica-neue',
                    fontWeight: FontWeight.w700,
                    fontSize: 32),
              ),
            )
          ],
        ),
      ),
    );
  }
}
