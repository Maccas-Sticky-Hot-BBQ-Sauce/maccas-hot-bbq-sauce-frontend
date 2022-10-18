import 'package:flutter/material.dart';

class RouteButton extends StatelessWidget {
  final String text;
  final bool active;
  final GestureTapCallback onPressed;
  const RouteButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.active})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: active
          ? ElevatedButton.styleFrom(
              primary: const Color(0xFF1B4B87),
              onPrimary: const Color(0xFFFFE832),
              fixedSize: const Size(119, 74),
            )
          : ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
              fixedSize: const Size(119, 74),
              side: const BorderSide(color: Colors.black, width: 2)),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'helvetica-neue',
          fontWeight: FontWeight.w700,
          fontSize: 36,
        ),
      ),
    );
  }
}
