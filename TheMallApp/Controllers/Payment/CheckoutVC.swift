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
    @IBOutlet weak var addressView: UIView!
    
    
    var key = ""
    var addressId = ""
    var addressData = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressView.layer.cornerRadius = 10
        addressView.layer.borderWidth = 1
        addressView.layer.borderColor = UIColor.lightGray.cgColor
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getAddress()
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


extension CheckoutVC{
    func getAddress(){
        ApiManager.shared.addressById(addressId: self.addressId) { [self] isSuccess in
            if isSuccess{
                self.addressData = ApiManager.shared.dataDict
                
                customerName.text = addressData.object(forKey: "fullName") as! String
                address.text = "\(addressData.object(forKey: "buildingNo") as! String),\(addressData.object(forKey: "street") as! String),\(addressData.object(forKey: "city") as! String),\(addressData.object(forKey: "state") as! String),\(addressData.object(forKey: "pinCode") as! String),Near \(addressData.object(forKey: "area") as! String)"
                mobileNumber.text = addressData.object(forKey: "mobileNo") as! String
                
//                self.fullName.text = data?.object(forKey: "fullName") as! String
//                self.mobileNumber.text = data?.object(forKey: "mobileNo") as! String
//                self.flat.text = data?.object(forKey: "buildingNo") as! String
//                self.street.text = data?.object(forKey: "street") as! String
//                self.city.text = data?.object(forKey: "city") as! String
//                self.state.text = data?.object(forKey: "state") as! String
//                self.pincode.text = data?.object(forKey: "pinCode") as! String
//                self.landmark.text = data?.object(forKey: "area") as! String
                
            }else{
                self.alert(message: ApiManager.shared.msg)
            }
        }
    }
}
