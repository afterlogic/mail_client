import UIKit
import Flutter
import CoreData
import UserNotifications
import NotificationCenter
import BackgroundTasks
import UserNotifications
import alarm_service
import Firebase
import receive_sharing
import ios_notification_handler

@UIApplicationMain
class AppDelegate: FlutterAppDelegate{
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        UserDefaults().set(Bundle.main.object(forInfoDictionaryKey:"ShareGroup") as! String,forKey: SwiftReceiveSharingPlugin.shareGroupKey)
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        }
        
        GeneratedPluginRegistrant.register(with: self)
        let version = UIDevice.current.systemVersion
        let iosVersion = NSString(string: version).doubleValue
        if (iosVersion >= 13 && iosVersion < 14) {
            let notificationOption = launchOptions?[.remoteNotification]
            if let notification = notificationOption as? [String:AnyObject]{
                showNotification(notification)
            }
        }
        return  super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        SwiftIosNotificationHandlerPlugin.reciveNotification(didReceiveRemoteNotification: userInfo,fetchCompletionHandler: completionHandler)
    }
    
    func showNotification(_ notification :[String:AnyObject]){
        let notificationCenter = UNUserNotificationCenter.current()
        let identifier = notification["To"] as? String ?? ""
        let content = UNMutableNotificationContent()
        content.userInfo=["payload":notification["To"] as? String ?? ""]
        content.title = notification["From"] as? String ?? ""
        content.body = notification["Subject"] as? String ?? ""
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        notificationCenter.add(request)
    }
}
