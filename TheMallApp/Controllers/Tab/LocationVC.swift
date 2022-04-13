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
    
    var selectedRows:[IndexPath] = []
    
    var key = ""
    var storeData = [AnyObject]()
    var storeId = ""
    var userId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = UserDefaults.standard.value(forKey: "id") as! String
        setdata()
        if key == ""{
            backBtn.isHidden = true
        }else{
            backBtn.isHidden = false
        }
        self.map.bringSubviewToFront(mapTable)
        
    }
    
    func setdata(){
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
    }
    
    @IBAction func backTapped(_ sender: Any) {
        if key == "S"{
            self.dismiss(animated: true, completion: nil)
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func likeTapped(_ sender: UIButton){
      
        storeId = storeData[sender.tag]["_id"] as! String
        
        let favModel = favouriteModel(userId: userId, storeId: storeId)
        ApiManager.shared.favUnFav(model: favModel) { isSuccess in
            if isSuccess{
                print("success")
            }else{
                print("success")
            }
        }
        
        let selectedIndexPath = IndexPath(row: sender.tag, section: 0)
        if self.selectedRows.contains(selectedIndexPath)
        {
            self.selectedRows.remove(at: self.selectedRows.firstIndex(of: selectedIndexPath)!)
        }
        else
        {
            self.selectedRows.append(selectedIndexPath)
        }
        self.mapTable.reloadData()
    }
}

extension LocationVC: UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mapTable.dequeueReusableCell(withIdentifier: "cell") as! MapTableCell
        cell.like.tag = indexPath.row
        
        cell.shopName.text = storeData[indexPath.row]["name"] as! String
        cell.label.text = storeData[indexPath.row]["description"] as! String
        
        if selectedRows.contains(indexPath)
        {
            cell.like.setImage(UIImage(named: "likeActive"), for: .normal)
            
        }
        else
        {
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
