//
//  ResetPassword.swift
//  TheMallApp
//
//  Created by Macbook on 04/02/22.
//

import UIKit

class ResetPassword: UIViewController {

    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmPass.isSecureTextEntry = true

    }
    
    @IBAction func resetPassword(_ sender: UIButton){
        ApiManager.shared.resetPassword(password: newPassword.text!) { (success) in
            if success{
                self.showAlertWithTwoActions(alertTitle: "Reset password", message: "Password changed please login", action1Title: "No", action1Style: .destructive, action2Title: "Yes", completion1: nil) { (ok) in
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else{
                print("Not Changed completion false")
            }
        }
       
    }
    @IBAction func showTapped(_ sender: UIButton){
        if confirmPass.isSecureTextEntry == true{
            confirmPass.isSecureTextEntry = false
        }else{
            confirmPass.isSecureTextEntry = true
        }
    }

}
