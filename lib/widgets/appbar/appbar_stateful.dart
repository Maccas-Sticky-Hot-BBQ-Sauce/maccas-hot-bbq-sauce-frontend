import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maccas_sticky_hot_bbq_sauce/utilities/time_util.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/appbar/appbar.dart';

class AppBarStateful extends StatefulWidget implements PreferredSizeWidget {
  const AppBarStateful({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppBarStatefulState();

  @override
  Size get preferredSize => const Size.fromHeight(140);
}

class _AppBarStatefulState extends State<AppBarStateful> {
  late String _time;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    _time = TimeUtil.formatDateTime(DateTime.now());
    Timer.periodic(
        const Duration(seconds: 1),
        (Timer t) => setState(() {
              _time = TimeUtil.getTime(_time);
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBarWidget(appBar: AppBar(), time: _time);
  }
}
