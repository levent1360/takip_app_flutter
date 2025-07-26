import UIKit
import Flutter
import FirebaseCore

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private let channelName = "app.channel.shared.data"
  private var sharedText: String?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // 🔧 Eksik satır eklendi
    GeneratedPluginRegistrant.register(with: self)

    // Firebase başlatılıyor
    if FirebaseApp.app() == nil {
        FirebaseApp.configure()
    }

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController

    let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)

    methodChannel.setMethodCallHandler { [weak self] (call, result) in
      if call.method == "getSharedText" {
        result(self?.sharedText)
        self?.sharedText = nil
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    if let url = launchOptions?[.url] as? URL {
      sharedText = url.absoluteString
    } else if let activityDict = launchOptions?[.userActivityDictionary] as? [AnyHashable: Any],
              let userActivity = activityDict["UIApplicationLaunchOptionsUserActivityKey"] as? NSUserActivity,
              let incomingUrl = userActivity.webpageURL {
      sharedText = incomingUrl.absoluteString
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    sharedText = url.absoluteString

    if let controller = window?.rootViewController as? FlutterViewController {
      let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)
      methodChannel.invokeMethod("onNewSharedText", arguments: sharedText)
    }

    return true
  }
}
