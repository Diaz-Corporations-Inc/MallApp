//
//  AppDelegate.swift
//  TheMallApp
//
//  Created by mac on 01/02/2022.
//

import UIKit
import IQKeyboardManagerSwift
import AKSideMenu
import Stripe
import Firebase
import FirebaseCore
import FirebaseMessaging


 @main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        STPPaymentConfiguration.shared.publishableKey = "pk_test_51KngJVBiDeUCfD4ORTbtSjnKHz70xFjFSmViJDKXwXPu6P0dikWzf5ZbUQw8QOZLmn4wYZXFnDrJr7NcFuC0shXn00u0XzJ9x1"
        IQKeyboardManager.shared.enable = true
        ////
        ///
        ///
        ///
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
                let pushNotificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
                application.registerUserNotificationSettings(pushNotificationSettings)

                Messaging.messaging().delegate = self
                
                let token = Messaging.messaging().fcmToken
                print("did launch token\(token)")

                if #available(iOS 10.0, *) {
                    // For iOS 10 display notification (sent via APNS)
                    UNUserNotificationCenter.current().delegate = self
                    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                    UNUserNotificationCenter.current().requestAuthorization(
                    options: authOptions,
                    completionHandler: {_, _ in })
                    // For iOS 10 data message (sent via FCM
                } else {
                    let settings: UIUserNotificationSettings =
                    UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
                      application.registerUserNotificationSettings(settings)
                }
                
                    application.registerForRemoteNotifications()
                FirebaseApp.configure()

        return true
    }
    ///
    ///
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
          
          let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
          let token = tokenParts.joined()
          print("Device Token: \(token)")
          
          let ttook = Messaging.messaging().fcmToken
          
       //   UIApplication.shared.applicationIconBadgeNumber = badgeCount + 1
          print("ye token: \(ttook)")
          if ttook != nil{
              UserDefaults.standard.set(ttook!, forKey: "devicetoken")
          }else{
              
          }
      }
    ///
    ///
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
           
           let tokenn = Messaging.messaging().fcmToken
           print("tooookeeen \(tokenn)")
           print("Firebase registration token: \(fcmToken)")
            
         //  let dataDict:[String: String] = ["token": fcmToken]
         //  NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
       //  UserDefaults.standard.set(fcmToken, forKey: "devicetoken")
       // TODO: If necessary send token to application server.
       // Note: This callback is fired at each app startup and whenever a new token is generated.
       }
///
    ///
    ///
    ///
    func application(_ application: UIApplication, didReceiveRemoteNotification
           userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            print("APN recieved")
            // print(userInfo)
            
            let state = application.applicationState
            switch state {
                
            case .inactive:
                print("Inactive")
                
            case .background:
                print("Background")
                // update badge count here
                application.applicationIconBadgeNumber = application.applicationIconBadgeNumber + 1
                
            case .active:
                print("Active")

            }
        }
    
    
    
    ///
//        func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
//               print("Received data message: \(remoteMessage.appData)")
//           }
     ///
    internal func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
           
                   let userInfo = notification.request.content.userInfo
   //                print(userInfo)
   //                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationrefresh"), object: nil)

               guard let aps = userInfo[AnyHashable("aps")] as? NSDictionary,let badge = aps["badge"] as? Int, let alert = aps["alert"] as? NSDictionary,let body = alert["body"] as? String, let title = alert["title"] as? String else {
               // handle any error here
                       return
                   }
               
               //  Print full message.
                   print("tap on on forground app",userInfo)
                   print("titleeeee\(title)")
                   print("body \(body)")
                   print("badge \(badge)")

//                   badgeCount = badge;
//                   if badgeCount > 0{
//                       badgeCount += 1
//                   }else{
//                     //  badgeCount = 0
//                   }
                 // UIApplication.shared.applicationIconBadgeNumber = badgeCount
    }
///
//        func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
//            print(remoteMessage.appData)
//        }
///
    func didReceive(_ request: UNNotificationRequest,
                       withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void){
        }
        ///
       func applicationWillResignActive(_ application: UIApplication) {
           NotificationCenter.default.post(name: NSNotification.Name(rawValue: "stopvideo"), object: nil)
       //   badgeCount = 0;
       }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // This method handles opening custom URL schemes (for example, "your-app://")
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        let stripeHandled = StripeAPI.handleURLCallback(with: url)
        if (stripeHandled) {
            return true
        } else {
            // This was not a Stripe url – handle the URL normally as you would
        }
        return false
    }

    // This method handles opening universal link URLs (for example, "https://example.com/stripe_ios_callback")
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool  {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            if let url = userActivity.webpageURL {
                let stripeHandled = StripeAPI.handleURLCallback(with: url)
                if (stripeHandled) {
                    return true
                } else {
                    // This was not a Stripe url – handle the URL normally as you would
                }
            }
        }
        return false
    }
}

