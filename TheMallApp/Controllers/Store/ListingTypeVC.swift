//
//  ListingTypeVC.swift
//  TheMallApp
//
//  Created by mac on 19/02/2022.
//

import UIKit

class ListingTypeVC: UIViewController {

    @IBOutlet weak var storeListingBtn: UIButton!
    var key = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if key == "Upgrade"{
            storeListingBtn.isHidden = true
        }else{
            storeListingBtn.isHidden = false
        }
    }
    
    @IBAction func backTapped(_ sender: UIButton){
            self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func storeListing(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CardVC") as! CardVC
        UserDefaults.standard.setValue("store", forKey: "storetype")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func storeListingWithItem(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CardVC") as! CardVC
        UserDefaults.standard.setValue("storePro", forKey: "storetype")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
