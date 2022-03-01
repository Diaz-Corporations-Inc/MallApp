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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.map.bringSubviewToFront(mapTable)
        
    }
    
    @IBAction func likeTapped(_ sender: UIButton){
    
    }
   
}

extension LocationVC: UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mapTable.dequeueReusableCell(withIdentifier: "cell") as! MapTableCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StoreVC") as! StoreVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
