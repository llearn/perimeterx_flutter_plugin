import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

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
  final _perimeterxFlutterPlugin = PerimeterXFlutter();

  Future<void> getHeaders() async {
    try {
      _pxHeaders = await _perimeterxFlutterPlugin.getHeaders();
    } on Exception {
      _pxHeaders = null;
    }

    setState(() {});
  }

  Future<void> getChallenge() async {
    try {
      final pxHeaders = await _perimeterxFlutterPlugin.getHeaders();
      final url = Uri.https('sample-ios.pxchk.net', '/login');
      final response = await http.get(url, headers: pxHeaders);
      print(
          'PERIMETERX_FLUTTER_PLUGIN_EXAMPLE: ${response.statusCode} ${response.body}');
      if (response.statusCode == 403) {
        _challengeResult = await _perimeterxFlutterPlugin.handleResponse(
            response: response.body, url: url.toString());

        switch (_challengeResult!) {
          case PerimeterxResult.solved:
            // retry your request
            break;
          case PerimeterxResult.cancelled:
            // retry your request. The challenge will be presented again.
            break;
          case PerimeterxResult.failed:
            // handle the error
            break;
        }
      }
    } on Exception {
      _challengeResult = null;
    }
    setState(() {});
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
                const Divider(),
                if (_challengeResult != null)
                  Text(
                    'Challenge result: ${_challengeResult!.name}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                    ),
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
