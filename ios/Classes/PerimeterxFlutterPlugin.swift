import Flutter
import UIKit

public class PerimeterxFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
      PerimeterXHostApiSetup.setUp(binaryMessenger: registrar.messenger(), api: PerimeterXHostApiImpl())
  }
}
