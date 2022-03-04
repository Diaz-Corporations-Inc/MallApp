//
//  LoginVC.swift
//  TheMallApp
//
//  Created by Macbook on 03/02/22.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    @IBAction func loginTapped(_ sender: UIButton){
        if email.text != "" || password.text != ""{
            let modeldata = loginModel(email: email.text!, password: password.text!)
            ApiManager.shared.login(model: modeldata) { (success) in
                if success{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.alert(message: "Please check email and password", title: "Login Failed")
                }
            }
        }
        else{
            self.alert(message: "Please fill all fields")
        }

    }
    
    @IBAction func forgetTapped(_ sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showTapped(_ sender: UIButton){
        if password.isSecureTextEntry == true{
            password.isSecureTextEntry = false
        }else{
            password.isSecureTextEntry = true
        }
    }
    
    @IBAction func registerTapped(_ sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUPVC") as! SignUPVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
