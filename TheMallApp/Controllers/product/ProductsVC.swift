//
//  ProductsVC.swift
//  TheMallApp
//
//  Created by M1 on 08/04/22.
//

import UIKit

class ProductsVC: UIViewController {

    @IBOutlet weak var addProductBtn: UIButton!
    @IBOutlet weak var productCollection: UICollectionView!
    
    var storeId = ""
    var data = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(storeId)
        getApiData()
    }

    @IBAction func backTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addProductTapped(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddProductVC") as! AddProductVC
        vc.storeId = self.storeId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProductsVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ShowProductCell
        cell.productPrice.text = "\(data[indexPath.item]["masterPrice"] as! Int)"
        cell.productName.text = data[indexPath.item]["name"] as! String
        if let gallery = data[indexPath.item]["gallery"] as? [AnyObject]{
            if gallery.count != 0{
                if let image = gallery[0]["name"] as? String{
                    let url = URL(string: "http://93.188.167.68/projects/mymall_nodejs/assets/images/\(image)")
                    if url != nil{
                        cell.productImage.af.setImage(withURL: url!)
                    }else{
                        print("hello")
                    }
                }

            }
        }
        return cell
    }    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: productCollection.frame.width/2, height: productCollection.frame.height/1.9 )
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
//        vc.productId = data[indexPath.row]["id"] as! String
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension ProductsVC{
    func getApiData(){
        ApiManager.shared.getStoreProducts(storeId: self.storeId) { isSuccess in
            if isSuccess{
                self.data = ApiManager.shared.data
                self.productCollection.reloadData()
            }else{
                self.alert(message: ApiManager.shared.msg)            }
        }
    }
    
}
