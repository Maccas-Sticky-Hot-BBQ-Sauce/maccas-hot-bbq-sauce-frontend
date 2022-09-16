import 'package:flutter/material.dart';

import '../images/app_logo.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  String time;
  final AppBar appBar;

  AppBarWidget({
    Key? key,
    required this.time,
    required this.appBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leadingWidth: 600,
      leading: Container(
        margin: const EdgeInsets.fromLTRB(36, 0, 0, 0),
        child: appLogo,
      ),
      actions: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 36, 0),
              child: Text(
                time,
                style: const TextStyle(
                    fontFamily: 'helvetica-neue',
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                    color: Colors.black),
              ),
            )
          ],
        ),
      ],
      toolbarHeight: 140,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(140);
}
