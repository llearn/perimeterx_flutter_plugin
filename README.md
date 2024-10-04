# perimeterx_flutter_plugin

A Flutter plugin for [`PerimeterX`](https://edocs.humansecurity.com/docs/overview).

|             | Android | iOS   |
|-------------|---------|-------|
| **Support** | SDK 21+ | 12.0+ |

## Example

<?code-excerpt "lib/basic.dart (basic-example)"?>
```dart
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
```

## Configuration

### iOS

In `AppDelegate` start the PerimeterX befere with your `APP_ID`.

Example:
```swift
import Flutter
import UIKit
import PerimeterX_SDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

      GeneratedPluginRegistrant.register(with: self)
      
      do {
          let policy = PXPolicy()
          policy.urlRequestInterceptionType = .none
          policy.doctorCheckEnabled = false
          try PerimeterX.start(appId: "API_ID", delegate: nil, policy: policy)
      }
      catch {
          print("error: \(error)")
      }
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

### Android

#### Add Theme.AppCompat.Light style

The SDK requires that the `Theme.AppCompat.Light` style will be set as the application's theme and create a `MainApplication` in your app. You should add it to the `AndroidManifest.xml` file:

<?code-excerpt "android/app/src/main/AndroidManifest.xml (android-queries)" plaster="none"?>
```xml
<application>
    android:name=".MainApplication"
    android:theme="@style/Theme.AppCompat.Light"
</application>
```

#### Add the permissions

You should add it to the `AndroidManifest.xml` file:

<?code-excerpt "android/app/src/main/AndroidManifest.xml (android-queries)" plaster="none"?>
```xml
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
<uses-permission android:name="android.permission.INTERNET" />
```



#### Start the SDK

The automatic interceptor is not supported in Flutter, so any request from the Dart code has to be handled manually. Here is an example in `MainApplication.kt`:

```kotlin
class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        try {
            val policy = PXPolicy()
            policy.storageMethod = PXStorageMethod.DATA_STORE
            policy.urlRequestInterceptionType = PXPolicyUrlRequestInterceptionType.NONE
            policy.doctorCheckEnabled = false
            PerimeterX.start(this, "APP_ID", null, policy)
        }
        catch (exception: Exception) {
            println("failed to start. exception: $exception")
        }
    }
}
```
