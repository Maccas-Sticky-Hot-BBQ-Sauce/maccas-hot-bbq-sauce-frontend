import 'dart:async';
import 'package:flutter/material.dart';
import 'package:maccas_sticky_hot_bbq_sauce/widgets/appbar/appbar.dart';
import 'package:maccas_sticky_hot_bbq_sauce/screens/timetable.dart';
import 'package:maccas_sticky_hot_bbq_sauce/utilities/time_util.dart';
import 'package:maccas_sticky_hot_bbq_sauce/services/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  ApiService.getStopData('4975');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QLDBus',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'QLD Bus Stop Explorer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String _time;

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
    return Scaffold(
        appBar: AppBarWidget(
          time: _time,
          appBar: AppBar(),
        ),
        body: const Timetable(
          title: 'Timetable',
        ));
  }
}
