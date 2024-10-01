import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:perimeterx_flutter_plugin/perimeterx_flutter_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, String>? _pxHeaders;
  PerimeterxResult? _challengeResult;
  final _perimeterxFlutterPlugin = PerimeterxFlutterPlugin.instance;

  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> getHeaders() async {
    try {
      _pxHeaders = await _perimeterxFlutterPlugin.getPerimeterxHeaders();
    } on Exception {
      _pxHeaders = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
    });
  }

  Future<void> getChallenge() async {
    try {
      // TODO: challenge example (https://edocs.humansecurity.com/docs/android-integration-with-flutter-v3)
      // _challengeResult = _perimeterxFlutterPlugin.handlePerimeterxResponse();
    } on Exception {
      _challengeResult = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Perimeterx example app'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_pxHeaders != null)
                  for (var key in _pxHeaders!.keys)
                    Text(
                      '$key: ${_pxHeaders![key]}',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                TextButton(
                  onPressed: () {
                    getHeaders();
                  },
                  child: const Text('Get Perimeterx Headers'),
                ),
                TextButton(
                  onPressed: () {
                    getChallenge();
                  },
                  child: const Text(
                    'Perimeterx Challenge',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
