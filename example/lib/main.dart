import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:holding_gesture/holding_gesture.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _counter = 0;

  void _incrementCounter() {
    if (mounted) {
      setState(() {
        _counter += 1;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('holding_gesture'),
        ),
        body: Center(
          child: Text('$_counter'),
        ),
        floatingActionButton: HoldDetector(
          onHold: _incrementCounter,
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: _incrementCounter,
          ),
        ),
      ),
    );
  }
}
