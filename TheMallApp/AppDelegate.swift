//
//  AppDelegate.swift
//  TheMallApp
//
//  Created by mac on 01/02/2022.
//

import UIKit
import IQKeyboardManagerSwift
import AKSideMenu
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        IQKeyboardManager.shared.enable = true
        //UserDefaults.standard.removeObject(forKey: "Role")

        // Create content and menu controllers
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let splash = storyboard.instantiateViewController(withIdentifier: "Splash") as! Splash
//        let navigationController = UINavigationController.init(rootViewController: splash)
//        let leftMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenu
//        let rightMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenu
//
//        // Create side menu controller
//        let sideMenuViewController: AKSideMenu = AKSideMenu(contentViewController: navigationController, leftMenuViewController: leftMenuViewController, rightMenuViewController: rightMenuViewController)
//
//        // Make it a root controller
//        self.window?.rootViewController = sideMenuViewController
//
//        self.window?.backgroundColor = UIColor.white
//        self.window?.makeKeyAndVisible()
        
        return true
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


}

