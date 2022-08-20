//
//  OTPVC.swift
//  TheMallApp
//
//  Created by Macbook on 03/02/22.
//

import UIKit
import ARSLineProgress
class OTPVC: UIViewController {

    
    @IBOutlet weak var otp: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func backTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextTapped(_ sender: UIButton){
        if otp.text != ""{
            ARSLineProgress.show()
            ApiManager.shared.otpVerify(otp: otp.text!) { (success) in
                ARSLineProgress.hide()
                if success{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResetPassword") as! ResetPassword
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.alert(message: "Please enter valid otp",title: "OTP")
                }
            }
        }else{
            ARSLineProgress.hide()
            self.alert(message: ApiManager.shared.msg)        }
        
        
    }
    @IBAction func resendTapped(_ sender: UIButton){
     print("hello")
    }
}
