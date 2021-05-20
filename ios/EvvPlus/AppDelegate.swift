import UIKit
import Flutter
import GoogleMaps
import Firebase

@UIApplicationMain
 @objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GMSServices.provideAPIKey("AIzaSyDZAQUd8vts_TmuXngtyYut_m88ZxR6X7k")
    //GMSPlacesClient.provideAPIKey("AIzaSyBgK46hLK9TsEwONMQFXSsobEEc0NIj9ow")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
