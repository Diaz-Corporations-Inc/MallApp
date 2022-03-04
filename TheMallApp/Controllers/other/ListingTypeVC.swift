//
//  ListingTypeVC.swift
//  TheMallApp
//
//  Created by mac on 19/02/2022.
//

import UIKit

class ListingTypeVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func storeListing(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StoreDetailsVC") as! StoreDetailsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func storeListingWithItem(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StoreDetailsVC") as! StoreDetailsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
