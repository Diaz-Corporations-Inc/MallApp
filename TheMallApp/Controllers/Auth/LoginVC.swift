//
//  LoginVC.swift
//  TheMallApp
//
//  Created by Macbook on 03/02/22.
//

import UIKit
import ARSLineProgress
class LoginVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.value(forKey: "id") != nil{
            print(UserDefaults.standard.value(forKey: "id") as! String)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        email.text = "test@gmail.com"
        password.text = "12345"
        password.isSecureTextEntry = true
    }
    @IBAction func loginTapped(_ sender: UIButton){
        if email.text != "" || password.text != ""{
            ARSLineProgress.show()
            let modeldata = loginModel(email: email.text!, password: password.text!)
            ApiManager.shared.login(model: modeldata) { (success) in
                if success{
                    ARSLineProgress.hide()
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.alert(message: ApiManager.shared.msg, title: "Login Failed")
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
