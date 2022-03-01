//
//  Splash.swift
//  TheMallApp
//
//  Created by Macbook on 07/02/22.
//

import UIKit

class Splash: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    

    @IBAction func skipTapped(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "FirstVC") as! FirstVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func nextTapped(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "FirstVC") as! FirstVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
