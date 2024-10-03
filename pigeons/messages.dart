import 'package:pigeon/pigeon.dart';

// #docregion config
@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/pigeon/messages.pigeon.dart',
    kotlinOut:
        'android/src/main/kotlin/com/arthurmonteiroo/perimeterx_flutter_plugin/messages/GeneratedAndroidPerimeterXFlutter.kt',
    swiftOut: 'ios/Classes/GeneratedSwiftPerimeterXFlutter.swift',
    kotlinOptions: KotlinOptions(
      package: 'com.arthurmonteiroo.perimeterx_flutter_android.messages',
    ),
  ),
)
// #enddocregion config

@HostApi()
abstract class PerimeterXHostApi {
  Map<String, String> getHeaders();

  @async
  String handleResponse({
    required String response,
    required String url,
  });
}
