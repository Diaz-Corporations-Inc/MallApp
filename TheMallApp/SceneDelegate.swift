//
//  SceneDelegate.swift
//  TheMallApp
//
//  Created by mac on 01/02/2022.
//

import UIKit
import AKSideMenu
import PlacesPicker
import GoogleMaps
import GooglePlaces


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = UIViewController()
        if UserDefaults.standard.value(forKey: "id") == nil{
             vc = storyboard.instantiateViewController(withIdentifier: "Splash") as! Splash
        }else{
             vc = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        }
        let navigationController = UINavigationController.init(rootViewController: vc)
        let leftMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenu
        let rightMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenu

        // Create side menu controller
        let sideMenuViewController: AKSideMenu = AKSideMenu(contentViewController: navigationController, leftMenuViewController: leftMenuViewController, rightMenuViewController: rightMenuViewController)

        // Make it a root controller
        self.window?.rootViewController = sideMenuViewController
        navigationController.isNavigationBarHidden = true
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        
        let googlekey = "AIzaSyBz4PZ6RlDaZeVNoiCvPDXkZMnc1Avu-1o"
        GMSServices.provideAPIKey(googlekey)
        GMSPlacesClient.provideAPIKey(googlekey)
        PlacePicker.configure(googleMapsAPIKey: googlekey, placesAPIKey: googlekey)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

