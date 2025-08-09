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

        GeneratedPluginRegistrant.register(with: self)

        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }

        // App Group'tan veriyi oku
        let userDefaults = UserDefaults(suiteName: "group.com.truyazilim.takip.shared") // App Group adın
        sharedText = userDefaults?.string(forKey: "sharedText")
        userDefaults?.removeObject(forKey: "sharedText")

        let controller = window?.rootViewController as! FlutterViewController
        let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)

        methodChannel.setMethodCallHandler { [weak self] (call, result) in
            if call.method == "getSharedText" {
                result(self?.sharedText)
                self?.sharedText = nil
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
