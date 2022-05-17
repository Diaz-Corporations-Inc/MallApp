//
//  CardVC.swift
//  TheMallApp
//
//  Created by Macbook on 06/03/22.
//

import UIKit
import Stripe
import ARSLineProgress
import Alamofire
import CreditCardForm

class CardVC: UIViewController, STPPaymentCardTextFieldDelegate, UITextFieldDelegate {
    
    @IBOutlet var viewBorder: [UIView]!
    @IBOutlet var cardholdername_Field: UITextField!
    @IBOutlet weak var CreditCard: CreditCardFormView!
    let viewModel = TransactionViewModel()

    @IBOutlet weak var continueBtn: UIButton!
    var key = ""
    var addressId = ""
    let paymentTextField = STPPaymentCardTextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        cardholdername_Field.delegate = self
//        CreditCard.cardHolderString = "polo"
        for i in 0...viewBorder.count-1{
            viewBorder[i].layer.cornerRadius = 5
            viewBorder[i].layer.borderWidth = 1
            viewBorder[i].layer.borderColor = UIColor(named:"border")?.cgColor

        }
        cardholdername_Field.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        // Set up stripe textfield
        paymentTextField.frame = CGRect(x: 15, y: 199, width: self.view.frame.size.width - 20, height: 44)
        paymentTextField.translatesAutoresizingMaskIntoConstraints = false
        paymentTextField.borderWidth = 0

        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: paymentTextField.frame.size.height - width, width:  paymentTextField.frame.size.width, height: paymentTextField.frame.size.height)
        border.borderWidth = width
        paymentTextField.layer.addSublayer(border)
        paymentTextField.layer.masksToBounds = true

        view.addSubview(paymentTextField)

        NSLayoutConstraint.activate([
        paymentTextField.topAnchor.constraint(equalTo: CreditCard.bottomAnchor, constant: 20),
        paymentTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        paymentTextField.widthAnchor.constraint(equalToConstant: self.view.frame.size.width-20),
        paymentTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        paymentTextField.delegate = self
        
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        CreditCard.cardHolderString = date.text!
//    }
 
    @objc func textFieldDidChange(_ textField: UITextField) {
        CreditCard.cardHolderString = cardholdername_Field.text!
        
    }
    ///
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        CreditCard.paymentCardTextFieldDidChange(cardNumber: textField.cardNumber, expirationYear: UInt(textField.expirationYear), expirationMonth: UInt(textField.expirationMonth), cvc: textField.cvc)
    }

    func paymentCardTextFieldDidEndEditingExpiration(_ textField: STPPaymentCardTextField) {
        CreditCard.paymentCardTextFieldDidEndEditingExpiration(expirationYear: UInt(textField.expirationYear))
    }

    func paymentCardTextFieldDidBeginEditingCVC(_ textField: STPPaymentCardTextField) {
        CreditCard.paymentCardTextFieldDidBeginEditingCVC()
    }

    func paymentCardTextFieldDidEndEditingCVC(_ textField: STPPaymentCardTextField) {
        CreditCard.paymentCardTextFieldDidEndEditingCVC()
    }
    
    ///
    @IBAction func complete(_ sender: Any) {
            
        if cardholdername_Field.text == "" || paymentTextField.cardNumber == "" || "\(paymentTextField.expirationMonth)" == "" || "\(paymentTextField.expirationYear)" == "" || "\(paymentTextField.cvc)" == "" {
            self.alert(message: "Please enter card details")
        }else{
            self.viewModel.proceedPayment(cardNumber: paymentTextField.cardNumber!, cardholdername: cardholdername_Field.text!, expiryMonth: UInt(paymentTextField.expirationMonth), expiryYear: UInt(paymentTextField.expirationYear), cardCVC: paymentTextField.cvc!) { [self] isSuccess in
                if isSuccess{
                    if key == ""{
                        let vc = storyboard?.instantiateViewController(withIdentifier: "StoreDetailsVC") as! StoreDetailsVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else{
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoneVC") as! DoneVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }else{
                    self.alert(message: "Payment failed")
                }
            }
        }
        
    }
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
  

}

//extension CardVC{
//    func Createtransactions(productid: String, amount: String, source : String)
//        {
//            if ReachabilityNetwork.isConnectedToNetwork(){
//                self.view.isUserInteractionEnabled = false
//                let token = UserDefaults.standard.value(forKey: "token") as! String
//                let headers : HTTPHeaders = ["x-access-token":token]
//                let parms : [String: Any] = ["productId":"624d27cfda80f62f639fe812","amount":200,"source":"nkb"]
//                AF.request(Api.updateStore, method: .post, parameters: parms, encoding: JSONEncoding.default, headers: headers).responseJSON
//                { [self]
//                    response in
//                    //ARSLineProgress.hide()
//                    print(parms)
//                    switch(response.result)
//                    {
//                    case.success(let json):
//                        do {
//                            print("success===",json)
//                            let statusCode = response.response?.statusCode
//                            let response = json as! NSDictionary
//                            if(statusCode == 200)
//                            {
//                                ARSLineProgress.hide()
//                                print(response)
//                                let message = response.object(forKey: "message") as! String
//                                alert(message: "payment Successfull")
//                                OrderPlace()
//                                self.view.isUserInteractionEnabled = true
//                            }else{
//                                self.view.isUserInteractionEnabled = true
//                                //                            let message = response.object(forKey: "error") as! String
//                                //                            self.alert(message: message)
//                                ARSLineProgress.hide()
//                            }
//                        }
//                    case .failure(let error):
//                        print("not sucess",error)
//                        ARSLineProgress.hide()
//                        self.view.isUserInteractionEnabled = true
//                    }
//                }
//            }else{
//                //            let saveddata = UserDefaults.standard.value(forKey: "savedarray")! as! [AnyObject]
//                //            ProductArray = saveddata
//                alert(message: "No inernet connection")
//                ARSLineProgress.hide()
//            }
//        }
//}
