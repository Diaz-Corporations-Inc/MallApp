//
//  CartVC.swift
//  TheMallApp
//
//  Created by mac on 09/02/2022.
//

import UIKit
import Stripe
import StripeCore
import StripeUICore
import StripeApplePay
import ARSLineProgress

class CartVC: UIViewController {

    @IBOutlet weak var emptyCartView: UIView!
    @IBOutlet weak var cartTable: UITableView!{
        didSet{
            cartTable.tableFooterView = UIView(frame: .zero)
        }
    }
    @IBOutlet weak var checkoutButton: UIButton!
    var cartData = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
      }
       
    override func viewWillAppear(_ animated: Bool) {
        getCart()
        
    }
    
    @IBAction func optionBtnTapped(_ sender: UIButton) {
        let id = cartData[sender.tag]["_id"] as! String
        print("sd",id)
        print("sd")
        ARSLineProgress.show()
        ApiManager.shared.deleteCart(id: id) { isSuccess in
            ARSLineProgress.hide()
            if isSuccess{
                self.getCart()
                print("deletedSuccessfully")
            }
            else{
                print("error")
            }
        }
    }
    
    @IBAction func buyTapped(_ sender:UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "CardVC") as! CardVC
        vc.key = "Cart"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func deleteTapped(_ sender:UIButton){
        
    }

}
class CartTablecell: UITableViewCell{
    
    @IBOutlet weak var cartView: UIView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var color: UILabel!
    @IBOutlet weak var quantity: UILabel!
}

extension CartVC{
    func getCart(){
        ARSLineProgress.show()
        let id = UserDefaults.standard.value(forKey: "id") as! String
        ApiManager.shared.getCart(id: id) {[self] isSuccess in
            print(id)
            ARSLineProgress.hide()
            if isSuccess{
                self.cartData = ApiManager.shared.data
                if cartData.count == 0{
                    cartTable.isHidden = true
                    emptyCartView.isHidden = false
                    checkoutButton.isHidden = true
                }else{
                    cartTable.isHidden = false
                    emptyCartView.isHidden = true
                    checkoutButton.isHidden = false
                }
                cartTable.reloadData()
            }else{
                print("hii")
            }
        }
    }
}
extension CartVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTable.dequeueReusableCell(withIdentifier: "cell") as! CartTablecell
        cell.deleteBtn.tag = indexPath.row
        cell.cartView.layer.cornerRadius = 20
        cell.cartView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.cartView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cell.cartView.layer.shadowRadius = 2
        cell.cartView.layer.shadowOpacity = 5
        let product = cartData[indexPath.row]["product"] as! NSDictionary
        cell.quantity.text = "Quantity - \(cartData[indexPath.row]["quantity"] as! Int)"
        cell.productName.text = product.object(forKey: "name") as! String
        cell.color.text = "Color - Red"
        cell.price.text = "Price - \(product.object(forKey: "masterPrice") as! Int) $"
        if let gallery = product.object(forKey: "gallery") as? [AnyObject]{
            if gallery.count != 0{
                if let image = gallery[0]["name"] as? String{
                    let url = URL(string: "http://93.188.167.68/projects/mymall_nodejs/assets/images/\(image)")
                    if url != nil{
                        cell.cartImage.af.setImage(withURL: url!)
                    }else{
                        print("hello")
                    }
                }
            }else{
                print("hii")
            }
          
                
        }
        return cell
    }
    
    
}
