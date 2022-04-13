//
//  BrowseAllVC.swift
//  TheMallApp
//
//  Created by mac on 08/02/2022.
//

import UIKit
import ARSLineProgress

class BrowseAllVC: UIViewController {

    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var browseTable: UITableView!
    var a = ""
    
    var selectedRows:[IndexPath] = []
    var storeData = [AnyObject]()
    var storeId = ""
    var userId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = UserDefaults.standard.value(forKey: "id") as! String

        setData()
        if a == ""{
            backbtn.isHidden = true
        }else{
            backbtn.isHidden = false
        }
    }
    
    func setData(){
        ARSLineProgress.show()
        ApiManager.shared.storeList { [self] isSuccess in
            ARSLineProgress.hide()
            if isSuccess{
                storeData = ApiManager.shared.data
                browseTable.reloadData()
            }else{
                print("hello")
            }
        }
    }
    
    @IBAction func likeTapped(_ sender: UIButton) {
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
        self.browseTable.reloadData()
    }
    @IBAction func detailTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StoreVC") as! StoreVC
        vc.key = "df"
        vc.storeId = storeData[sender.tag]["_id"] as! String
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func scrolldown(_ sender: Any) {
    }
    @IBAction func mikeTapped(_ sender: Any) {
    }
    @IBAction func backTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func browseNearYou(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
        vc.key = "B"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension BrowseAllVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = browseTable.dequeueReusableCell(withIdentifier: "cell") as! BrowseCell
        
        cell.likeBtn.tag = indexPath.row
        
        cell.storeName.text = storeData[indexPath.row]["name"] as! String
        cell.available.text = storeData[indexPath.row]["description"] as! String
        
        if selectedRows.contains(indexPath)
        {
            cell.likeBtn.setImage(UIImage(named: "likeActive"), for: .normal)
            
        }
        else
        {
            cell.likeBtn.setImage(UIImage(named: "likeInactive"), for: .normal)
            
        }
        return cell
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "StoreVC") as! StoreVC
//        vc.storeId = storeData[indexPath.row]["_id"] as! String
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
}
