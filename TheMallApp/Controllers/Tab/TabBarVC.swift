//
//  TabBarVC.swift
//  TheMallApp
//
//  Created by Macbook on 07/02/22.
//

import UIKit

class TabBarVC: UITabBarController {

//    let shared = TabBarVC()
    var count = 1
    var role = ""
    var btn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        count = 1
        self.tabBar.items![2].isEnabled = false
        
        setupMiddleButton()
        
        // Do any additional setup after loading the view.
    }
    func hello(){
        let myTabBarItem1 = (self.tabBar.items?[2])! as UITabBarItem
//        myTabBarItem1.image = UIImage(named: "black")
//        myTabBarItem1.selectedImage = UIImage(named: "black")
    }
    
    func setupMiddleButton() {
  
         let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-25, y: -20, width: 50, height: 50))
            btn = middleBtn
         
        btn.setImage(UIImage(named: "favourite"), for: .normal)
        btn.layer.cornerRadius = 25
        
            //add to the tabbar and add click event
        
            self.tabBar.addSubview(middleBtn)
       
        btn.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)

        self.view.layoutIfNeeded()
        
        }

        // Menu Button Touch Action
        @objc func menuButtonAction(sender: UIButton) {
            self.selectedIndex = 2
            let story = UIStoryboard(name: "Main", bundle: nil)
            let vc = story.instantiateViewController(withIdentifier: "FavoutiteVC") as! FavoutiteVC
            self.viewControllers?[2] = vc
              
        }
   

}













    //        setTabBarItems()
    //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //        let vc = storyboard.instantiateViewController(withIdentifier: "ListingTypeVC") as! ListingTypeVC
    //        let vc1 = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
    //
    //       role = UserDefaults.standard.value(forKey: "Role") as! String
    //        if role == "User"{
    //            self.viewControllers?[0] = vc1
    //        }else{
    //            self.viewControllers?[0] = vc
    //
    //        }
            
//        }
    //    func setTabBarItems(){
    //
    //          let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
    //          myTabBarItem1.image = UIImage(named: "homeActive")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
    //          myTabBarItem1.selectedImage = UIImage(named: "homeActive ")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
    //    }
