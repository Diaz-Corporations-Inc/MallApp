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
    var amount = 0.0
    var storeType = ""
    var storeData = NSDictionary()
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
        
        if key == "" || key == "Upgrade"{
            if UserDefaults.standard.value(forKey: "storetype") as? String == "store"{
                amount = 305.00
            }else{
                amount = 655.00
            }
            
        }
        print("storedata",storeData)
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
            self.viewModel.proceedPayment(cardNumber: paymentTextField.cardNumber!, cardholdername: cardholdername_Field.text!, expiryMonth: UInt(paymentTextField.expirationMonth), expiryYear: UInt(paymentTextField.expirationYear), cardCVC: paymentTextField.cvc!) { [self] token, isSuccess in
                if isSuccess{
                    payment(stripeToken: "tok_visa")
                }else{
                    self.alert(message: "Payment failed please try again after some time")
                }
            }
        }
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CardVC{
    func payment(stripeToken: String){
        ARSLineProgress.show()
        let user = UserDefaults.standard.value(forKey: "id") as! String
        let model = PaymentModel(userId: user, amount: self.amount*100,currency:"USD", source: stripeToken)
        print(model,"model")
        print("hello")
        ApiManager.shared.createTransaction(model: model) {[self] isSuccess in
            ARSLineProgress.hide()
            if isSuccess{
                if key == "" || key == "Upgrade"{
                    self.showAlertWithOneAction(alertTitle: "My Mall", message: "Payment successful", action1Title: "Ok") { ok in
                        if key == "Upgrade"{
                            let vc = storyboard?.instantiateViewController(withIdentifier: "StoreDetailsVC") as! StoreDetailsVC
                            vc.key = "Upgrade"
                            if storeData != nil{
                                vc.storeData = self.storeData
                            }
                           
                            self.navigationController?.pushViewController(vc, animated: true)
                        }else{
                            let vc = storyboard?.instantiateViewController(withIdentifier: "StoreDetailsVC") as! StoreDetailsVC
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                        
                    }
                   
                }else{
                    getOrder()
                    
                }
            }else{
                self.alert(message: ApiManager.shared.msg)
            }
        }
            
        
    }
    
}

extension CardVC{
    func getOrder(){
        ARSLineProgress.show()
        let user = UserDefaults.standard.value(forKey: "id") as! String
        let cart = UserDefaults.standard.value(forKey: "cartIds") as! [NSDictionary]
        ApiManager.shared.placeOrder(userId: user, AddressId: addressId, amount: "\(amount)", cart: cart) { isSuccess in
            ARSLineProgress.hide()
            if isSuccess{
                print("hello order placed")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoneVC") as! DoneVC
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                self.alert(message: ApiManager.shared.msg)
            }
        }
    }
}
