//
//  CardVC.swift
//  TheMallApp
//
//  Created by Macbook on 06/03/22.
//

import UIKit

class CardVC: UIViewController {
    
    @IBOutlet var viewBorder: [UIView]!
    @IBOutlet weak var continueBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0...viewBorder.count-1{
            viewBorder[i].layer.cornerRadius = 5
            viewBorder[i].layer.borderWidth = 1
            viewBorder[i].layer.borderColor = UIColor(named:"border")?.cgColor


        }
        
    }
    
    
    @IBAction func complete(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StoreDetailsVC") as! StoreDetailsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func yearBtn(_ sender: Any) {

    }
    @IBAction func monthBtn(_ sender: Any) {
       
        
    }
  

}
