import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:maccas_sticky_hot_bbq_sauce/models/landmark_model.dart';

class Landmark extends StatefulWidget {
  const Landmark({Key? key, required this.landmark}) : super(key: key);

  final LandmarkModel landmark;

  @override
  State<StatefulWidget> createState() => _LandmarkState();
}

class _LandmarkState extends State<Landmark> {
  @override
  Widget build(BuildContext context) {
    LandmarkModel landmark = widget.landmark;
    double distance = landmark.distance;
    return SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.all(30.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                            )),
                      ),
                      const Text(
                        "Details",
                        style: TextStyle(
                            fontFamily: 'helvetica-neue',
                            fontWeight: FontWeight.w500,
                            fontSize: 44),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 24, 0),
                        child: Text(
                          landmark.name,
                          style: const TextStyle(
                              fontFamily: 'helvetica-neue',
                              fontWeight: FontWeight.w400,
                              fontSize: 40),
                        ),
                      ),
                      Text(
                        '$distance m',
                        style: const TextStyle(
                            fontFamily: 'helvetica-neue',
                            fontWeight: FontWeight.w700,
                            fontSize: 32),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 1080,
                  height: 382,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: landmark.imgB64 != null
                      ? Image.memory(base64Decode(landmark.imgB64!))
                      : const Image(
                          image: ExactAssetImage("assets/images/no-photo.jpg"),
                          height: 210,
                          width: 210,
                        ),
                ),
                Container(
                  width: 1016,
                  height: 270,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 32),
                  child: Text(landmark.description != null
                      ? landmark.description!
                      : ''),
                ),
                if (landmark.url != null)
                  Container(
                    width: 196,
                    height: 196,
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 32),
                    child: QrImage(data: landmark.url!),
                  )
              ])),
    );
  }
}
