//
//  OTPVC.swift
//  TheMallApp
//
//  Created by Macbook on 03/02/22.
//

import UIKit

class OTPVC: UIViewController {

    
    @IBOutlet weak var otp: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func backTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextTapped(_ sender: UIButton){
        ApiManager.shared.otpVerify(otp: otp.text!) { (success) in
            if success{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResetPassword") as! ResetPassword
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                print("Completion false please check otp")
            }
        }
        
    }
    @IBAction func resendTapped(_ sender: UIButton){
     print("hello")
    }
}
