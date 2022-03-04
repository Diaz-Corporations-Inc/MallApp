//
//  StoreDetailsVC.swift
//  TheMallApp
//
//  Created by mac on 15/02/2022.
//

import UIKit
import Stripe
import StripeUICore

class StoreDetailsVC: UIViewController {

    @IBOutlet var viewCollOutlet: [UIView]!
    @IBOutlet weak var doneBtn: UIButton!
    
    var paymentSheet: PaymentSheet?
    var configuration = PaymentSheet.Configuration()

    override func viewDidLoad() {
        super.viewDidLoad()

//        doneBtn.addTarget(self, action: #selector(didTapCheckoutButton), for: .touchUpInside)

        
        STPAPIClient.shared.publishableKey = "pk_test_51KQragSCNzQLiBK9jhU8YtCRQ2rUj6QgCP1bzdLochzKPpAt9jRCGhviW8do0h7Gk1h2Ev8CQiSPcHbI4mZHbSxk00eEK6atkv"
             configuration.merchantDisplayName = "Example, Inc."
//             configuration.customer = .init(id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
//        configuration.customer = .init(id: "", ephemeralKeySecret: "pk_test_51KQragSCNzQLiBK9jhU8YtCRQ2rUj6QgCP1bzdLochzKPpAt9jRCGhviW8do0h7Gk1h2Ev8CQiSPcHbI4mZHbSxk00eEK6atkv")
             // Set `allowsDelayedPaymentMethods` to true if your business can handle payment
             // methods that complete payment after a delay, like SEPA Debit and Sofort.
             configuration.allowsDelayedPaymentMethods = true
             self.paymentSheet = PaymentSheet(paymentIntentClientSecret: "", configuration: configuration)
        
        for i in 0...viewCollOutlet.count-1{
            viewCollOutlet[i].layer.cornerRadius = 10
            viewCollOutlet[i].layer.shadowOpacity = 3
            viewCollOutlet[i].layer.shadowRadius = 5
            viewCollOutlet[i].layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            viewCollOutlet[i].layer.shadowColor = UIColor.gray.cgColor
        
        }
        doneBtn.layer.cornerRadius = 10
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ImageUploadVC") as! ImageUploadVC
        self.navigationController?.pushViewController(vc, animated: true)
//        didTapCheckoutButton()
    }
    @IBAction func backTapped(_ sender: Any) {
//        didTapCheckoutButton()
    }
    
@objc func didTapCheckoutButton(){
        paymentSheet?.present(from: self) { paymentResult in
            // MARK: Handle the payment result
            switch paymentResult {
            case .completed:
              print("Your order is confirmed")
            case .canceled:
              print("Canceled!")
            case .failed(let error):
              print("Payment failed: \(error)")
            }
          }
    }

}
