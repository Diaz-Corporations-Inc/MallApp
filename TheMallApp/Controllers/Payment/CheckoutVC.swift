//
//  CheckoutVC.swift
//  TheMallApp
//
//  Created by Macbook Air (ios) on 06/05/22.
//

import UIKit

class CheckoutVC: UIViewController {

    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var mobileNumber: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var deliveryCharge: UILabel!
    @IBOutlet weak var totalPayable: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backTapped(_ sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkout(_ sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CardVC") as! CardVC
        vc.key = "Checkout"
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
