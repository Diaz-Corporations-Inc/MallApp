//
//  AddAddressVC.swift
//  TheMallApp
//
//  Created by Macbook Air (ios) on 28/04/22.
//

import UIKit
import ARSLineProgress

class AddAddressVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var roundView: [UIView]!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var mobileNumber: UITextField!
    @IBOutlet weak var flat: UITextField!
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var landmark: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var pincode: UITextField!
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var saveAddressBtn: UIButton!
    
    var key = ""
    var addressId = ""
    var isDefault = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkBox.setImage(UIImage(named: "checkbox"), for: .normal)
        for i in 0...roundView.count-1{
            roundView[i].layer.cornerRadius = 10
            roundView[i].layer.borderColor = UIColor.lightGray.cgColor
            roundView[i].layer.borderWidth = 1
        }
        getAddressData()
        print(addressId,key)
        if key == ""{
            titleLabel.text = "Add address"
        }else{
            titleLabel.text = "Edit your address"
        }
    }
    
    @IBAction func backTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func mallLogoTappped(_ sender: Any) {
        NavigateToHome.sharedd.navigate(naviagtionC: self.navigationController!)
    }
    
    @IBAction func checkBox(_ sender: UIButton){
        if isDefault == true{
            isDefault = false
            checkBox.setImage(UIImage(named: "checkbox"), for: .normal)
            
        }else{
            isDefault = true
            checkBox.setImage(UIImage(named: "checkboxActive"), for: .normal)
        }
    }
    
    @IBAction func saveAddress(_ sender: UIButton){
       
            let user = UserDefaults.standard.value(forKey: "id") as! String
        print(isDefault)
            let model = AddAddressModel(userId: user, fullName: fullName.text ?? "", mobileNo: mobileNumber.text ?? "", area: landmark.text ?? "", buildingNo: flat.text ?? "", city: city.text ?? "", state: state.text ?? "", pinCode: pincode.text ?? "", street: street.text ?? "", isdefault: isDefault)
        if key == ""{
            ApiManager.shared.addAddress(model: model) { isSuccess in
                if isSuccess{
                    self.showAlertWithOneAction(alertTitle: "My Mall", message: ApiManager.shared.msg, action1Title: "Ok") { isSuccess in
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    self.alert(message: ApiManager.shared.msg)
                }
            }
    }else{
        ApiManager.shared.updateAddress(model: model, AddressId: self.addressId){
            isSuccess in
            if isSuccess {
                self.showAlertWithOneAction(alertTitle: "My Mall", message: "Address updated", action1Title: "Ok") { ok in
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                self.alert(message: ApiManager.shared.msg)
            }
        }
    }
    }
}
       

extension AddAddressVC{
    func getAddressData(){
        ARSLineProgress.show()
        ApiManager.shared.addressById(addressId: self.addressId){
            isSuccess in
            ARSLineProgress.hide()
            if isSuccess{
                let data = ApiManager.shared.dataDict
                self.fullName.text = data?.object(forKey: "fullName") as! String
                self.mobileNumber.text = data?.object(forKey: "mobileNo") as! String
                self.flat.text = data?.object(forKey: "buildingNo") as! String
                self.street.text = data?.object(forKey: "street") as! String
                self.city.text = data?.object(forKey: "city") as! String
                self.state.text = data?.object(forKey: "state") as! String
                self.pincode.text = data?.object(forKey: "pinCode") as! String
                self.landmark.text = data?.object(forKey: "area") as! String
                
            }else{
                print("checkAddressId")
            }
        }
    }
   
}
