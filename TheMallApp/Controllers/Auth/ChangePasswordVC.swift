//
//  ChangePasswordVC.swift
//  TheMallApp
//
//  Created by mac on 25/02/2022.
//

import UIKit
import ARSLineProgress

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var changeView: UIView!
    @IBOutlet var textCollOutlet: [UIView]!
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        newPassword.isSecureTextEntry = true
        btn.layer.cornerRadius = 20
        mainView.layer.cornerRadius = 25
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        changeView.layer.cornerRadius = 25
        changeView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
       
        for i in 0...textCollOutlet.count-1{
            textCollOutlet[i].layer.cornerRadius = 12
            textCollOutlet[i].layer.borderColor = UIColor.lightGray.cgColor
            textCollOutlet[i].layer.borderWidth = 1
        }
       
    }
    
    @IBAction func changePassword(_ sender: Any) {
        if oldPassword.text == "" || newPassword.text == "" || confirmPassword.text == ""{
            alert(message: "Please enter all fields")
        }else if newPassword.text != confirmPassword.text{
            alert(message: "Please enter same password",title: "Password Don't match")
        }
        else{
            let model = changePassModel(oldPassword: oldPassword.text!, newPassword: newPassword.text!)
            ARSLineProgress.show()
            ApiManager.shared.changePass(model: model) { (success) in
                ARSLineProgress.hide()
                if success{
                    self.showAlertWithOneAction(alertTitle: "Change password", message: "Password Updated Successfully", action1Title: "OK") { (ok) in
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    self.alert(message: "Please check password",title: "Change Password")
                }
            }
        }
       
    }
    @IBAction func backTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func showTapped(_ sender: Any) {
        if newPassword.isSecureTextEntry == true{
            newPassword.isSecureTextEntry = false
        }else{
            newPassword.isSecureTextEntry = true
        }
    }
    @IBAction func forgotTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
