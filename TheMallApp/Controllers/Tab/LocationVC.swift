//
//  LocationVC.swift
//  TheMallApp
//
//  Created by Macbook on 07/02/22.
//

import UIKit
import MapKit
import CoreLocation
import ARSLineProgress

class LocationVC: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    
    @IBOutlet weak var map : MKMapView!
    
    @IBOutlet weak var mapTable: UITableView!{
        didSet{
            mapTable.tableFooterView = UIView(frame: .zero)
        }
    }
    @IBOutlet weak var backBtn : UIButton!
 
///
    var selectedRows:[IndexPath] = []
    var key = ""
    var storeData = [AnyObject]()
    var storeId = ""
    var userId = ""
 ///
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = UserDefaults.standard.value(forKey: "id") as? String ?? ""
        setdata()
        if key == ""{
            backBtn.isHidden = true
        }else{
            backBtn.isHidden = false
        }
        self.map.bringSubviewToFront(mapTable)
        
    }
///
    func setdata(){
        if userId == ""{
            ARSLineProgress.show()
            ApiManager.shared.storeList { [self] isSuccess in
                ARSLineProgress.hide()
                if isSuccess{
                    storeData = ApiManager.shared.data
                    print(storeData)
                    mapTable.reloadData()
                }
                else{
                    print("api not working")
                }
            }
        }else{
            ARSLineProgress.show()
            ApiManager.shared.storeListWithTOken{ [self] isSuccess in
                ARSLineProgress.hide()
                if isSuccess{
                    storeData = ApiManager.shared.data
                    print(storeData)
                    mapTable.reloadData()
                }
                else{
                    print("api not working")
                }
            }
        }
      
    }
    //MARK: - BUTTON ACTIONS
///
    @IBAction func backTapped(_ sender: Any) {
        if key == "S"{
            self.dismiss(animated: true, completion: nil)
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
///
    @IBAction func mallLogoTapped(_ sender: Any) {
        NavigateToHome.sharedd.navigate(naviagtionC: self.navigationController!)
    }
    
 ///
    @IBAction func likeTapped(_ sender: UIButton){
      
        if userId != ""{
            storeId = storeData[sender.tag]["_id"] as! String
            let favModel = favouriteModel(userId: userId, storeId: storeId)
            ApiManager.shared.favUnFav(model: favModel) { isSuccess in
                if isSuccess{
                    print("success")
                    self.setdata()
                }else{
                    print("success")
                }
            }
        }else{
            self.showAlertWithOneAction(alertTitle: "Oops!", message: "You are not logged in please login to continue", action1Title: "OK") { isSuccess in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }
       
    }
}

extension LocationVC: UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mapTable.dequeueReusableCell(withIdentifier: "cell") as! MapTableCell
        cell.like.tag = indexPath.row
        cell.like.setImage(UIImage(named: "likeInactive"), for: .normal)
        if storeData.count != 0{
            cell.shopName.text = storeData[indexPath.row]["name"] as! String
            cell.label.text = storeData[indexPath.row]["description"] as! String
            if let image = storeData[indexPath.row]["logo"] as? String{
                let url = URL(string: "http://93.188.167.68/projects/mymall_nodejs/assets/images/\(image)")
                if url != nil{
                    cell.shopImage.af.setImage(withURL: url!)
                }else{
                    cell.shopImage.image = UIImage(named: "c2")
                }
            }
        }
        guard let isFavorite = storeData[indexPath.row]["isFav"] as? Bool else{ return cell}
        if isFavorite == true{
            cell.like.setImage(UIImage(named: "likeActive"), for: .normal)
        }else{
            cell.like.setImage(UIImage(named: "likeInactive"), for: .normal)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StoreVC") as! StoreVC
        vc.storeId = storeData[indexPath.row]["_id"] as! String
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
