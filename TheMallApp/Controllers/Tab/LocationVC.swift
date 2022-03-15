//
//  LocationVC.swift
//  TheMallApp
//
//  Created by Macbook on 07/02/22.
//

import UIKit
import MapKit
import CoreLocation

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if key == ""{
            backBtn.isHidden = true
        }else{
            backBtn.isHidden = false
        }
        self.map.bringSubviewToFront(mapTable)
        
    }
    @IBAction func backTapped(_ sender: Any) {
        
        if key == "S"{
            self.dismiss(animated: true, completion: nil)
        }else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func likeTapped(_ sender: UIButton){
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mapTable.dequeueReusableCell(withIdentifier: "cell") as! MapTableCell
        cell.like.tag = indexPath.row
        //
//        print("kjkasdvbsbvajbfvjhdbfjvhbdfjhv",selected)
        
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
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
