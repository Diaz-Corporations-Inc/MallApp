//
//  UpgradePlanVC.swift
//  TheMallApp
//
//  Created by Macbook Air (ios) on 26/04/22.
//

import UIKit

class UpgradePlanVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backTapped(_ sender: Any) {
    }
    
    @IBAction func mallLogoTapped(_ sender: Any) {
        NavigateToHome.sharedd.navigate(naviagtionC: self.navigationController!)
    }
    @IBAction func skipTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ListingTypeVC") as! ListingTypeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func upgradePlan(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StoreDetailsVC") as! StoreDetailsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
