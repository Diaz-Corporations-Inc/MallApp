//
//  ViewController.swift
//  TheMallApp
//
//  Created by mac on 01/02/2022.
//

import UIKit

class FirstVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    @IBAction func userTapped(_ sender: UIButton){
        UserDefaults.standard.setValue("User", forKey: "Role")
       
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    @IBAction func shopOwner(_ sender: UIButton){
        UserDefaults.standard.setValue("Shop", forKey: "Role")
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

