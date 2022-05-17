//
//  AddReviewVC.swift
//  TheMallApp
//
//  Created by Macbook Air (ios) on 26/04/22.
//

import UIKit
import Cosmos

class AddReviewVC: UIViewController {

    @IBOutlet weak var ratingView : CosmosView!
    @IBOutlet weak var ratingLabel : UILabel!
    @IBOutlet weak var review : UITextField!
    @IBOutlet weak var reviewBtn : UIButton!
    
    var productId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.ratingView.rating)
    }
    @IBAction func backTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func mallHomeTapped(_ sender: Any) {
        NavigateToHome.sharedd.navigate(naviagtionC: self.navigationController!)
    }
    @IBAction func addReviewTapped(_ sender: UIButton){
        
        let name = UserDefaults.standard.value(forKey: "name") as? String ?? ""
        let userId = UserDefaults.standard.value(forKey: "id") as? String ?? ""
//        let productId = productData.object(forKey: "_id") as? String ?? ""
        let model = ReviewModel(userId: userId, productId: productId, rating: Int(self.ratingView.rating), review: review.text, customerName: name)
        print(model)
        
        if review.text == "" {
            self.alert(message: "Please write review")
        }else{
            ApiManager.shared.addReview(model: model) { isSuccess in
                if isSuccess{
                    self.navigationController?.popViewController(animated: true)
                }else{
                    self.alert(message: ApiManager.shared.msg)
                }
            }
        }
    }
    
}
