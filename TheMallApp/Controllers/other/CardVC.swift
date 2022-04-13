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

class CardVC: UIViewController {
    
    @IBOutlet var viewBorder: [UIView]!
    @IBOutlet var cardno_field: UITextField!
    @IBOutlet var cardholdername_Field: UITextField!
    @IBOutlet var ccv_Field: UITextField!
    @IBOutlet var date: UITextField!

    @IBOutlet weak var continueBtn: UIButton!
    var key = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0...viewBorder.count-1{
            viewBorder[i].layer.cornerRadius = 5
            viewBorder[i].layer.borderWidth = 1
            viewBorder[i].layer.borderColor = UIColor(named:"border")?.cgColor

        }
        
    }
    
    
    @IBAction func complete(_ sender: Any) {
        if cardno_field.text == "" || cardholdername_Field.text == "" || ccv_Field.text == ""  || date.text == ""{
            alert(message: "please enter all fields")
        }else{
            
            if key == ""{
                let vc = storyboard?.instantiateViewController(withIdentifier: "StoreDetailsVC") as! StoreDetailsVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                
                
    //            let stripeCardParams = STPCardParams()
    //                    stripeCardParams.number = cardno_field.text
    //                    stripeCardParams.name = cardholdername_Field.text
    //                    stripeCardParams.expMonth = 11
    //                    stripeCardParams.expYear = 25
    //                    stripeCardParams.cvc = ccv_Field.text
    //
    //                    let config = STPPaymentConfiguration.shared
    //                    let stpApiClient = STPAPIClient(publishableKey: "pk_test_51HCYjQIyUd4AmPmvtzu4NPXWWlx6KoU6XIkm2H3z2wChgIlfLhbp6AYKPUxL408dyTqzkycn2QfntyGrk45ZxKdA00uXeiG9D3")
    //                    stpApiClient.createToken(withCard: stripeCardParams) { (token, error) in
    //
    //                    if error == nil {
    //
    //                    //Success
    //                    DispatchQueue.main.async {
    //                        print(token!.tokenId)
    //                        self.Createtransactions(productid: "60a38d6a42d36a73c69f8eae", amount: "2000", source: token!.tokenId)
    //                    }
    //
    //                    } else {
    //
    //                    //failed
    //                    self.alert(message: "\(error)")
    //                    print(error)
    //                    }
    //                    }
                ARSLineProgress.show()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    ARSLineProgress.hide()
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoneVC") as! DoneVC
                    self.navigationController?.pushViewController(vc, animated: true)
                })
                
            }
        }
    }
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
  

}

//extension CardVC{
//    func Createtransactions(productid: String, amount: String, source : String)
////        {
////            if ReachabilityNetwork.isConnectedToNetwork(){
////                self.view.isUserInteractionEnabled = false
////                let token = UserDefaults.standard.value(forKey: "token") as! String
////                let headers : HTTPHeaders = ["x-access-token":token]
////                let parms : [String: Any] = ["productId":"624d27cfda80f62f639fe812","amount":200,"source":"nkb"]
////                AF.request(Api.createtransactionsAPI, method: .post, parameters: parms, encoding: JSONEncoding.default, headers: headers).responseJSON
////                { [self]
////                    response in
////                    //ARSLineProgress.hide()
////                    print(parms)
////                    switch(response.result)
////                    {
////                    case.success(let json):
////                        do {
////                            print("success===",json)
////                            let statusCode = response.response?.statusCode
////                            let response = json as! NSDictionary
////                            if(statusCode == 200)
////                            {
////                                ARSLineProgress.hide()
////                                print(response)
////                                let message = response.object(forKey: "message") as! String
////                                alert(message: "payment Successfull")
////                                OrderPlace()
////                                self.view.isUserInteractionEnabled = true
////                            }else{
////                                self.view.isUserInteractionEnabled = true
////                                //                            let message = response.object(forKey: "error") as! String
////                                //                            self.alert(message: message)
////                                ARSLineProgress.hide()
////                            }
////                        }
////                    case .failure(let error):
////                        print("not sucess",error)
////                        ARSLineProgress.hide()
////                        self.view.isUserInteractionEnabled = true
////                    }
////                }
////            }else{
////                //            let saveddata = UserDefaults.standard.value(forKey: "savedarray")! as! [AnyObject]
////                //            ProductArray = saveddata
////                alert(message: "No inernet connection")
////                ARSLineProgress.hide()
////            }
////        }
//}
