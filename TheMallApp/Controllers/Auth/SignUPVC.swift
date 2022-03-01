//
//  SignUPVC.swift
//  TheMallApp
//
//  Created by Macbook on 03/02/22.
//

import UIKit

class SignUPVC: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var dobCom: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    @IBAction func loginTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showTapped(_ sender: UIButton){
        if password.isSecureTextEntry == true{
            password.isSecureTextEntry = false
        }else{
            password.isSecureTextEntry = true
        }
    }
    @IBAction func signUpTapped(_ sender: UIButton){
        let modelData = signUpModel(email: email.text!, password: password.text!, name: name.text!, dob: dobCom.text!)
        
        ApiManager.shared.signUp(model: modelData) { (success) in
            if success{
                let alert = UIAlertController.init(title: "Register", message: "Successfully registered please login to continue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { yes in
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }else{
                print("CompletionFail")
            }
        }
        
       
    }

}
