//
//  StoreVC.swift
//  TheMallApp
//
//  Created by mac on 14/02/2022.
//

import UIKit
import AVKit
import AKSideMenu
import ARSLineProgress

import AlamofireImage
class StoreVC: UIViewController {

    @IBOutlet weak var productbtn: UIButton!
    @IBOutlet weak var addStoreImageBtn: UIView!
   
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var scrollableView: UIView!
    @IBOutlet weak var storeDescription: UILabel!
    @IBOutlet weak var visitStore: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var storeCollection: UICollectionView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var companyImge: UIImageView!
    @IBOutlet weak var storeTiming: UILabel!
    @IBOutlet weak var storeLocation: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var priceRange: UILabel!
    
    var key = ""
    var myData = [AnyObject]()
    var storeId = ""
    var storeData : NSDictionary!
    var gallery = [AnyObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    override func viewWillAppear(_ animated: Bool) {
        if key == "My"{
            editBtn.isHidden = false
            addStoreImageBtn.isHidden = false
        }else{
            editBtn.isHidden = true
            addStoreImageBtn.isHidden = true
        }
        setData()
    }
   
    
    
///
    //MARK: - BUTTON ACTIONS
    @IBAction func editBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StoreDetailsVC") as! StoreDetailsVC
        vc.key = "S"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func backTapped(_ sender: Any) {
        if key == ""{
            self.navigationController?.popViewController(animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            let leftMenuViewController = storyboard?.instantiateViewController(withIdentifier: "SideMenu") as! SideMenu
            let rightMenuViewController = storyboard?.instantiateViewController(withIdentifier: "SideMenu") as! SideMenu
            let sideMenuViewController: AKSideMenu = AKSideMenu(contentViewController: vc, leftMenuViewController: leftMenuViewController, rightMenuViewController: rightMenuViewController)
            self.navigationController?.pushViewController(sideMenuViewController, animated: true)

        }
       
        
    }
    
    @IBAction func addStoreImagesTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddStoreImage") as! AddStoreImage
        vc.storeId = self.myData[0]["_id"] as! String
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func producttapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductsVC") as! ProductsVC
        if key == "My"{
            vc.storeId = myData[0]["_id"] as! String
        }else{
            vc.storeId = storeData.object(forKey: "_id") as! String
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func registoreStore(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ListingTypeVC") as! ListingTypeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func visitWebsite(_ sender: Any) {
       
    }
    
}

extension StoreVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if key == "My"{
            if myData.count == 0{
                scrollableView.isHidden = true
                editBtn.isHidden = true
                return 0
            }else{
                scrollableView.isHidden = false
                editBtn.isHidden = false
                return gallery.count
            }
        }else{
            return gallery.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = storeCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! StoreCell
        if key == "My"{
            if myData.count != 0{
                if let logoImage = self.gallery[indexPath.row]["name"] as? String{
                    DispatchQueue.main.async {
                        let url = URL(string: "http://93.188.167.68/projects/mymall_nodejs/assets/images/\(logoImage)")
                        if url != nil{
                            cell.cellImage.af.setImage(withURL: url!)
                        }else{
                            cell.cellImage.image = UIImage(named: "")

                        }
                    }
                }
            }

        }else{
            if storeData != nil{
                if let logoImage = self.gallery[indexPath.row]["name"] as? String{
                    DispatchQueue.main.async {
                        let url = URL(string: "http://93.188.167.68/projects/mymall_nodejs/assets/images/\(logoImage)")
                        if url != nil{
                            cell.cellImage.af.setImage(withURL: url!)
                        }else{
                            cell.cellImage.image = UIImage(named: "")
                        }
                    }
                }
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: storeCollection.frame.width/1.2, height: storeCollection.frame.height/1.2)
    }
    
    
    
}

class StoreCell: UICollectionViewCell{
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellImage: UIImageView!
}

extension StoreVC{
    func setData(){
        ARSLineProgress.show()
        if key == "My"{
            let id = UserDefaults.standard.value(forKey: "id") as! String
            ApiManager.shared.myStore(id: id) { [self]isSuccess in
                ARSLineProgress.hide()
               
                if isSuccess{
    
                     myData = ApiManager.shared.data
                    if myData.count != 0{
                        storeName.text = myData[0]["name"] as! String
                        storeDescription.text = myData[0]["description"] as! String
                        let timingDict = myData[0]["timing"] as! NSDictionary
                        storeTiming.text = "\(timingDict.object(forKey: "from") as? String ?? "") - \(timingDict.object(forKey: "to") as? String ?? "") "
                     let priceRangedict = myData[0]["priceRange"] as! NSDictionary
                        priceRange.text = "\(priceRangedict.object(forKey: "from") as? Int ?? 0) - \(priceRangedict.object(forKey: "to") as? Int ?? 0) $"
                        contact.text = myData[0]["contactNo"] as! String
                        storeLocation.text = "\(myData[0]["city"] as! String),\(myData[0]["state"] as! String),\(myData[0]["zipCode"] as! String),Near \(myData[0]["landmark"] as! String)"
                        gallery = myData[0]["gallery"] as! [AnyObject]
    //                    if let logo =
                        if let logoImage = myData[0]["logo"] as? String{
                            DispatchQueue.main.async {
                                let url = URL(string: "http://93.188.167.68/projects/mymall_nodejs/assets/images/\(logoImage)")
                                if url != nil{
                                    self.companyImge.af.setImage(withURL: url!)
                                }else{
                                    self.companyImge.image = UIImage(named: "")
                                }
                            }
                        }
                        
                        storeCollection.reloadData()
                    }
                 
                }else{
                    alert(message:ApiManager.shared.msg)
                }
            }
        }else{
            ApiManager.shared.storeById(storeid: storeId) { [self] stordata, isSuccess in
                ARSLineProgress.hide()
//                storeCollection.reloadData()
                if isSuccess{
                    storeData = stordata
                    storeName.text = storeData.object(forKey: "name") as! String
                    storeDescription.text = storeData.object(forKey: "description") as! String

                    let timingDict = storeData.object(forKey: "timing") as! NSDictionary
                    storeTiming.text = "\(timingDict.object(forKey: "from") as? String ?? "") - \(timingDict.object(forKey: "to") as? String ?? "") "
                 let priceRangedict = storeData.object(forKey: "priceRange") as! NSDictionary
                    priceRange.text = "\(priceRangedict.object(forKey: "from") as? Int ?? 0) - \(priceRangedict.object(forKey: "to") as? Int ?? 0) $"
                    contact.text = storeData.object(forKey: "contactNo") as? String ?? "-"
                    storeLocation.text = "\(storeData.object(forKey: "city") as! String),\(storeData.object(forKey: "state") as! String),\(storeData.object(forKey: "zipCode") as! String),Near \(storeData.object(forKey: "landmark") as! String)"
                    gallery = storeData.object(forKey: "gallery") as! [AnyObject]
                    
                    if let logoImage = storeData.object(forKey: "logo") as? String{
                        DispatchQueue.main.async {
                            let url = URL(string: "http://93.188.167.68/projects/mymall_nodejs/assets/images/\(logoImage)")
                            if url != nil{
                                companyImge.af.setImage(withURL: url!)
                            }else{
                                companyImge.image = UIImage(named: "")
                            }
                        }
                    }
                    
                    storeCollection.reloadData()
                }else{
                    ARSLineProgress.hide()
                    alert(message: ApiManager.shared.msg)
                }
            }

        }
        
    }
}
