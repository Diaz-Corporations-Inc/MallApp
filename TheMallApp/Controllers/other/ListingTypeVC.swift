//
//  ListingTypeVC.swift
//  TheMallApp
//
//  Created by mac on 19/02/2022.
//

import UIKit

class ListingTypeVC: UIViewController {

    var key = ""
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backTapped(_ sender: UIButton){
        if key == "S"{
            self.dismiss(animated: true, completion: nil)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func storeListing(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CardVC") as! CardVC
//        UserDefaults.standard.setValue("store", forKey: "storetype")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func storeListingWithItem(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CardVC") as! CardVC
//        UserDefaults.standard.setValue("storewithitems", forKey: "storetype")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
