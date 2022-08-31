import 'package:flutter/material.dart';

class RouteButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onPressed;
  const RouteButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          fixedSize: const Size(109, 74),
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
