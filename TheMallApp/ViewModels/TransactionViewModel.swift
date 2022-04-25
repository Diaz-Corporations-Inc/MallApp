//
//  TransactionViewModel.swift
//  TheMallApp
//
//  Created by Macbook Air (ios) on 18/04/22.
//

import Foundation
import Stripe

class TransactionViewModel{
    
    func proceedPayment(cardNumber: String , cardholdername: String, expiryMonth : UInt , expiryYear : UInt, cardCVC : String , completion : @escaping(Bool)->()){
        
        if cardholdername == "" || cardNumber == "" || expiryMonth == nil  || expiryYear == nil || cardCVC == ""{
            print("Please enter all fields")
            
        }else{
            
        
        let stripeCardParams = STPCardParams()
        stripeCardParams.number = cardNumber
        stripeCardParams.name = cardholdername
        stripeCardParams.expMonth = expiryMonth
        stripeCardParams.expYear = expiryYear
        stripeCardParams.cvc = cardCVC
        
        let config = STPPaymentConfiguration.shared
        let stpApiClient = STPAPIClient(publishableKey: "pk_test_51HCYjQIyUd4AmPmvtzu4NPXWWlx6KoU6XIkm2H3z2wChgIlfLhbp6AYKPUxL408dyTqzkycn2QfntyGrk45ZxKdA00uXeiG9D3")
        stpApiClient.createToken(withCard: stripeCardParams) { (token, error) in
            
            if error == nil {
                
                DispatchQueue.main.async {
                    print(token!.tokenId)
                    completion(true)
                    //                            self.Createtransactions(productid: "60a38d6a42d36a73c69f8eae", amount: "2000", source: token!.tokenId)
                }
                
            } else {
                completion(false)
                //failed
                //self.alert(message: "\(error)")
                print(error)
            }
        }
    }
    }
    
}
