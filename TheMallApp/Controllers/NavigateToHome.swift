//
//  NavigateToHome.swift
//  TheMallApp
//
//  Created by Macbook Air (ios) on 10/05/22.
//

import UIKit
import AKSideMenu

class NavigateToHome: UIViewController {
static var sharedd = NavigateToHome()
    
    func navigate(naviagtionC : UINavigationController){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        let navigationController = UINavigationController.init(rootViewController: vc)
        let leftMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenu
        let rightMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenu
        navigationController.isNavigationBarHidden = true
        // Create side menu controller
        let sideMenuViewController: AKSideMenu = AKSideMenu(contentViewController: navigationController, leftMenuViewController: leftMenuViewController, rightMenuViewController: rightMenuViewController)
        naviagtionC.pushViewController(sideMenuViewController, animated: true)
    }
    
}
