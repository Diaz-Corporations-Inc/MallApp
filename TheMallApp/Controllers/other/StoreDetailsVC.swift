//
//  StoreDetailsVC.swift
//  TheMallApp
//
//  Created by mac on 15/02/2022.
//

import UIKit

class StoreDetailsVC: UIViewController {

    @IBOutlet var viewCollOutlet: [UIView]!
    @IBOutlet weak var doneBtn: UIButton!
    


    override func viewDidLoad() {
        super.viewDidLoad()

//        doneBtn.addTarget(self, action: #selector(didTapCheckoutButton), for: .touchUpInside)

        
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
        self.navigationController?.popViewController(animated: true)
//        didTapCheckoutButton()
    }
  

}
