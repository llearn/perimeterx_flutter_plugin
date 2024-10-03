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
          try PerimeterX.start(appId: "PXj9y4Q8Em", delegate: nil, policy: policy)
      }
      catch {
          print("error: \(error)")
      }
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
