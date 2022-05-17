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
    @IBOutlet weak var brandName: UITextField!
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
    var filterArray = [String]()
    var categoryId = [String]()
    var catIdtoSend = ""
    var productid = ""
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        setData()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if productDescription.textColor == UIColor.lightGray{
            productDescription.text = ""
            productDescription.textColor = UIColor.black
        }else{
            productDescription.textColor = UIColor.black
        }
        
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
            print(productData,"rrr")
            productName.text = productData.object(forKey: "name") as! String
            productPrice.text = "\(productData.object(forKey: "masterPrice") as! Int)"
            productDescription.text = productData.object(forKey: "description") as? String ?? ""
            brandName.text = productData.object(forKey: "brand") as? String ?? ""
            discount.text = productData.object(forKey: "discount") as? String ?? ""
            catIdtoSend = productData.object(forKey: "categoryId") as? String ?? ""
            storeId = productData.object(forKey: "store") as? String ?? ""
            productid = productData.object(forKey: "id") as? String ?? ""
            print(productid,"rrrr")
//            productType.text = productData.object(forKey: "name") as! String
        }else{
            print("hello")
        }
    }
 ///
    @IBAction func mallLogoTapped(_ sender: Any) {
        NavigateToHome.sharedd.navigate(naviagtionC: self.navigationController!)
    }
    ///
    @IBAction func backTaped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
 ///
    @IBAction func continueTapped(_ sender: Any) {
         if productName.text == ""{
            alert(message: "Please enter product name")
        }else if productPrice.text == ""{
            alert(message: "Please enter product price")
        }else if brandName.text == ""{
            alert(message: "Please enter product Brand name")
        }else if productDescription.text == ""{
            alert(message: "Please enter description")
        }
        else{
                addProduct()
        }
        
    }

}

///
extension AddProductVC{
    func addProduct(){
        let size = sizeA(value: "M", price: 0)
        let color = colors(name: "Gray", price: 0)
        let feature = feature(key: "1", value: "10")
        let price = Double("\(self.productPrice.text!)")
        print(self.storeId,"dfgdfsg")
        var isDiscount = false
        if discount.text == ""{
            isDiscount = false
        }else{
            isDiscount = true
        }
        let model = AddProductModel(description: self.productDescription.text!, name: self.productName.text!, masterPrice: price, productUrl: "Nike", storeId: self.storeId, size: size, colors: color, features: feature,discount:discount.text, categoryId: catIdtoSend, brand: brandName.text!,isOnDiscount:isDiscount)
        print(model)
        print("sdnvkabvbakvbabvkabv")
        if key == "Edit"{
            ApiManager.shared.updateProducts(productId: self.productid, model: model) {[self] isSuccess in
                if isSuccess{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductImageUploadVC") as! ProductImageUploadVC
                    vc.productId = productid
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
//                    self.alert(message: ApiManager.shared.msg)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductImageUploadVC") as! ProductImageUploadVC
                    vc.productId = productid
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }else{
            ApiManager.shared.addProduct(model:model) { isSuccess in
                if isSuccess{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductImageUploadVC") as! ProductImageUploadVC
                    vc.productId = ApiManager.shared.dataDict.object(forKey: "_id") as! String
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.alert(message: ApiManager.shared.msg)
                }
            }
        }
      
    }
   
}


