//
//  ForgotPasswordVC.swift
//  TheMallApp
//
//  Created by Macbook on 03/02/22.
//

import UIKit
import ARSLineProgress
class ForgotPasswordVC: UIViewController {
    @IBOutlet weak var email: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func forgetTapped(_ sender: UIButton){
        if email.text != ""{
            let model = forgotPassword(email: email.text!)
            ARSLineProgress.show()
            ApiManager.shared.forgotPassword(email: model) { (Success) in
                ARSLineProgress.hide()
                if Success{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.alert(message: "Please enter valid email")
                }
            }
            
            
            
        }
        
    }
}
