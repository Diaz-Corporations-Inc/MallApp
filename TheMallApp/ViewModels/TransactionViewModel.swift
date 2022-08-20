//
//  TransactionViewModel.swift
//  TheMallApp
//
//  Created by Macbook Air (ios) on 18/04/22.
//

import Foundation
import Stripe

class TransactionViewModel{
    
    func proceedPayment(cardNumber: String , cardholdername: String, expiryMonth : UInt , expiryYear : UInt, cardCVC : String , completion : @escaping(String,Bool)->()){
        
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
        let stpApiClient = STPAPIClient(publishableKey: "pk_live_51KKTEbE5La7Ypz9fVbzwQaWNeL6lUCXUBRxC0qrhjAyfBbxPIvBIxZwUBsUvU4ttH0ftz0Vant4Xv6zknVeuco4G00bSKnwVUG")
        stpApiClient.createToken(withCard: stripeCardParams) { (token, error) in
            
            if error == nil {
                
                DispatchQueue.main.async {
                    print(token!.tokenId)
                    completion(String(token!.tokenId),true)

                }
                
            } else {
                completion("",false)
                //failed
                //self.alert(message: "\(error)")
                print(error)
            }
        }
    }
    }
    
}
