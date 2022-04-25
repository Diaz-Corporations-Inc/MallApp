//
//  AddProductVC.swift
//  TheMallApp
//
//  Created by M1 on 21/03/22.
//

import UIKit
import DropDown

class AddProductVC: UIViewController,UITextViewDelegate{
    
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var productType: UITextField!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var discount: UITextField!
    @IBOutlet var viewsCollection: [UIView]!
    
    var drop = DropDown()
    
    let sizeArray = ["S","M","L","XL","XXL"]
    let colorArray = ["s"]
    let imageArray = ["q"]
    var storeId = ""
    var key = ""
    var productData: NSDictionary!
    var productdata = [AnyObject]()
    var filterArray = ["Clothes","Electronics","Footwear","Beauty & Luxury beauty","Home & Kitchen","Groceries","Health & Household","Furniture","Computer & Accessories"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("c",storeId)
        productDescription.delegate = self
        productDescription.text = "Product description"
        productDescription.textColor = UIColor.gray
        for i in 0...viewsCollection.count-1{
            viewsCollection[i].layer.cornerRadius = 10
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        productDescription.text = ""
        productDescription.textColor = UIColor.black
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if productDescription.text == ""{
            productDescription.text = "Product description"
            productDescription.textColor = UIColor.lightGray
        }else{
            productDescription.textColor = UIColor.black
        }
    }
    func setData(){
        if key == "Edit"{
            productName.text = productData.object(forKey: "name") as! String
            productPrice.text = "\(productData.object(forKey: "masterPrice") as! Int)"
            productDescription.text = productData.object(forKey: "description") as! String
//            productType.text = productData.object(forKey: "name") as! String
        }else{
            print("hello")
        }
    }
    
    @IBAction func backTaped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func continueTapped(_ sender: Any) {
        addProduct()
    }
  
    @IBAction func selectCat(_ sender:UIButton){
        drop.dataSource = filterArray
        drop.anchorView = discount
        drop.show()
        drop.selectionAction = { [unowned self] (index, item) in
            productType.text = item
            drop.hide()
        }
    }

    

}



extension AddProductVC{
    func addProduct(){
        let size = sizeA(value: "M", price: 0)
        let color = colors(name: "Gray", price: 0)
        let feature = feature(key: "1", value: "10")
        let price = Int("\(self.productPrice.text!)")
        print(self.storeId,"dfgdfsg")
        let model = AddProductModel(description: self.productDescription.text!, name: self.productName.text!, masterPrice: price, productUrl: "Nike", storeId: self.storeId, size: size, colors: color, features: feature,discount:discount.text!)
        ApiManager.shared.addProduct(model:model) { isSuccess in
            if isSuccess{

                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductImageUploadVC") as! ProductImageUploadVC
                vc.productId = ApiManager.shared.dataDict.object(forKey: "_id") as! String
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                print("try again")
            }
        }
    }
}
