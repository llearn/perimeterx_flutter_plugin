import 'package:pigeon/pigeon.dart';

// #docregion config
@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/pigeon/messages.pigeon.dart',
    kotlinOut:
        'android/src/main/kotlin/com/arthurmonteiroo/perimeterx_flutter_plugin/messages/GeneratedAndroidPerimeterxFlutter.kt',
    swiftOut: 'ios/Classes/GeneratedSwiftPerimeterxFlutter.swift',
    kotlinOptions: KotlinOptions(
      package: 'com.arthurmonteiroo.perimeterx_flutter_android.messages',
    ),
  ),
)
// #enddocregion config

@HostApi()
abstract class PerimeterxHostApi {
  Map<String, String> getPerimeterxHeaders();
  @async
  String handlePerimeterxResponse({
    required String response,
    String? url,
  });
}
