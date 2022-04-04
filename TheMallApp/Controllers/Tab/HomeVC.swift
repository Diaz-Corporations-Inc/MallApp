//
//  HomeVC.swift
//  TheMallApp
//
//  Created by Macbook on 05/02/22.
//

import UIKit
import AKSideMenu
import ARSLineProgress

class HomeVC: UIViewController {

    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var mikeButton: UIButton!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var shopsCollection: UICollectionView!
    @IBOutlet weak var pickFavourite: UICollectionView!
    var storeData = [AnyObject]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setdata()
    }
    
    func setdata(){
        ARSLineProgress.show()
        ApiManager.shared.storeList { [self] isSuccess in
            ARSLineProgress.hide()
            if isSuccess{
                storeData = ApiManager.shared.data
                print(storeData)
                print(storeData.count)
                shopsCollection.reloadData()
                pickFavourite.reloadData()
            }else{
                print("hello")
            }
        }
    }
    
    
    @IBAction func contactUsTapped(_ sender: Any) {
    }
    @IBAction func registerTAPPED(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ListingTypeVC") as! ListingTypeVC
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func shopsNear(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
        vc.key = "H"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func shopFavourite(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FavoutiteVC") as! FavoutiteVC
        vc.a = "1"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func sideMenuTapped(_ sender: Any) {
        self.sideMenuViewController?.presentLeftMenuViewController()
    }
    
    @IBAction func mikeTapped(_ sender: Any) {
        
    }
    
    @IBAction func viewAll(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "BrowseAllVC") as! BrowseAllVC
        vc.a = "1"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}



extension HomeVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return storeData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == pickFavourite{
            let cell = pickFavourite.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PicFavouriteCell
            cell.mainView.layer.cornerRadius = 10
            cell.cellImage.layer.cornerRadius = 10
            cell.mainView.layer.borderWidth = 1
            cell.mainView.layer.borderColor = UIColor.gray.cgColor
            cell.mainView.layer.shadowColor = UIColor.gray.cgColor
            cell.mainView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cell.mainView.layer.shadowRadius  = 2
            cell.mainView.layer.shadowOpacity = 5
            return cell
        }
        else{
            let cell = shopsCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Shopscell
            cell.cellView.layer.cornerRadius = 20
            cell.cellView.layer.shadowColor = UIColor.gray.cgColor
            cell.cellView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cell.cellView.layer.shadowRadius  = 2
            cell.cellView.layer.shadowOpacity = 5
            print("sdfsdfsdf",storeData.count)
            print(storeData)
            print(storeData.count)
            cell.offerLabel.text = storeData[indexPath.row]["description"] as! String
            cell.shopOffer.text = storeData[indexPath.row]["name"] as! String
//            let dateStore = storeData[indexPath.row]["updatedAt"] as! String
//            let dateFormatterGet = DateFormatter()
//            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//            let dateFormatterPrint = DateFormatter()
//            dateFormatterPrint.dateFormat = "MMM dd,yyyy"
//
//            if let date = dateFormatterGet.date(from: dateStore) {
//                print(dateFormatterPrint.string(from: date))
//            } else {
//               print("There was an error decoding the string")
//            }
//
            return cell
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == pickFavourite{
            return CGSize(width: pickFavourite.frame.width/3, height: pickFavourite.frame.height/2)
        }else{
            return CGSize(width: shopsCollection.frame.width/1.3, height: shopsCollection.frame.height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "StoreVC") as! StoreVC
        vc.storeId = storeData[indexPath.row]["_id"] as! String
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
