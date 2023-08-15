import 'package:flutter/material.dart';
import 'package:holding_gesture/holding_gesture.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _counter = 0;
  bool _isLoading = false;

  void _incrementCounter() {
    if (mounted) {
      setState(() {
        _counter += 1;
      });
    }
  }

  void _updateLoading(bool value) {
    if (mounted) {
      setState(() {
        _isLoading = value;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed (or held) the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
        bottomNavigationBar: _isLoading ? LinearProgressIndicator() : null,
        persistentFooterButtons: [
          HoldDetector(
            onHold: _incrementCounter,
            holdTimeout: Duration(milliseconds: 200),
            enableHapticFeedback: true,
            child: ElevatedButton(
              onPressed: _incrementCounter,
              child: Text("onHold"),
            ),
          ),
          HoldTimeoutDetector(
            onTimeout: () {
              _incrementCounter();
              _updateLoading(false);
            },
            onTimerInitiated: () => _updateLoading(true),
            onCancel: () => _updateLoading(false),
            holdTimeout: Duration(milliseconds: 3000),
            enableHapticFeedback: true,
            child: ElevatedButton.icon(
              onPressed: () {},
              label: Text("onTimeout"),
              icon: _isLoading
                  ? SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : Icon(Icons.timer_3),
            ),
          ),
        ],
      ),
    );
  }
}
