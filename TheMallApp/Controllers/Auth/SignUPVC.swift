//
//  SignUPVC.swift
//  TheMallApp
//
//  Created by Macbook on 03/02/22.
//

import UIKit
import ARSLineProgress

class SignUPVC: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var dobCom: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true
        dobCom.delegate = self
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
        if email.text != "" || password.text != "" || name.text != "" || dobCom.text != ""{
            let modelData = signUpModel(email: email.text!, password: password.text!, name: name.text!, dob: dobCom.text!,fcmToken: UserDefaults.standard.value(forKey: "devicetoken") as? String ?? "notoken")
           
            ARSLineProgress.show()
            ApiManager.shared.signUp(model: modelData) { (success) in
                ARSLineProgress.hide()
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
            
           
        }else{
            self.alert(message: "Please enter all field")
        }
        }
        
        

}

extension SignUPVC{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        datePicker()
    }
    
    func datePicker(){
        let datepick = UIDatePicker()
        datepick.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datepick.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        dobCom.inputView = datepick

        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(done))
        
        let flexiblebtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([cancelBtn,flexiblebtn,doneBtn], animated: false)
        dobCom.inputAccessoryView = toolbar
    }
    
    @objc func cancel(){
        self.dobCom.resignFirstResponder()
    }
    
    
    @objc func done(){
        if let datePicker = dobCom.inputView as? UIDatePicker{
            datePicker.datePickerMode = .date
            let dateformatter  = DateFormatter()
            dateformatter.dateFormat = "MM/dd/yyyy"
            dobCom.text = dateformatter.string(from: datePicker.date)
            
            self.dobCom.resignFirstResponder()

        }
    }
        
}
