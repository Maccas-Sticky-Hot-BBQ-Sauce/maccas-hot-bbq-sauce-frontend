import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  DateTime now = DateTime.now();
  late String _time;

  @override
  void initState() {
    _time = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Image.asset(
          'assets/images/TRANSLink.png',
          width: 217,
          height: 60,
        ),
        actions: <Widget>[
          Text(
            _time,
            style: const TextStyle(
                fontFamily: 'helvetica-neue',
                fontWeight: FontWeight.w700,
                fontSize: 40,
                color: Colors.black),
          ),
        ],
        toolbarHeight: 140,
      ),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: Row(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                    child: Image.asset(
                      'assets/images/location-icon.png',
                      width: 64,
                      height: 64,
                    ),
                  ),
                  const Text(
                    'UQ Chancellors Place',
                    style: TextStyle(
                        fontFamily: 'helvetica-neue',
                        fontWeight: FontWeight.w500,
                        fontSize: 44),
                  )
                ],
              ),
            ),
            const Text(
              'Timetable',
              style: TextStyle(
                fontFamily: 'helvetica-neue',
                fontWeight: FontWeight.w700,
                fontSize: 44,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const Icon(
                    Icons.keyboard_arrow_left_sharp,
                    size: 100.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      return;
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF1B4B87),
                      onPrimary: const Color(0xFFFFE832),
                      fixedSize: const Size(109, 74),
                    ),
                    child: const Text(
                      'All',
                      style: TextStyle(
                        fontFamily: 'helvetica-neue',
                        fontWeight: FontWeight.w700,
                        fontSize: 36,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      return;
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        fixedSize: const Size(109, 74),
                        side: const BorderSide(color: Colors.black, width: 2)),
                    child: const Text(
                      '402',
                      style: TextStyle(
                        fontFamily: 'helvetica-neue',
                        fontWeight: FontWeight.w700,
                        fontSize: 36,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      return;
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        fixedSize: const Size(109, 74),
                        side: const BorderSide(color: Colors.black, width: 2)),
                    child: const Text(
                      '411',
                      style: TextStyle(
                        fontFamily: 'helvetica-neue',
                        fontWeight: FontWeight.w700,
                        fontSize: 36,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      return;
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        fixedSize: const Size(109, 74),
                        side: const BorderSide(color: Colors.black, width: 2)),
                    child: const Text(
                      '412',
                      style: TextStyle(
                        fontFamily: 'helvetica-neue',
                        fontWeight: FontWeight.w700,
                        fontSize: 36,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      return;
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                        fixedSize: const Size(109, 74),
                        side: const BorderSide(color: Colors.black, width: 2)),
                    child: const Text(
                      '428',
                      style: TextStyle(
                        fontFamily: 'helvetica-neue',
                        fontWeight: FontWeight.w700,
                        fontSize: 36,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_right_sharp,
                    size: 100.0,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    Icons.keyboard_arrow_up_sharp,
                    size: 100.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _time = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm').format(dateTime);
  }
}
