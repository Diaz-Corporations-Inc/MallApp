//
//  AddressVC.swift
//  TheMallApp
//
//  Created by Macbook Air (ios) on 28/04/22.
//

import UIKit

class AddressVC: UIViewController {

    @IBOutlet weak var addressTable: UITableView!
    @IBOutlet weak var mallHome: UIButton!
    
    var addressData = [AnyObject]()
    var count = 0
    var key = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        count = 0
       
    }
    override func viewWillAppear(_ animated: Bool) {
        getAddress()
    }
    func getAddress(){
        ApiManager.shared.getAddress {[self]  isSuccess in
            if isSuccess{
                self.addressData = ApiManager.shared.data
                addressTable.reloadData()
            }else{
                self.alert(message: ApiManager.shared.msg)
            }
        }
    }
    
    @IBAction func mallLogotapped(_ sender: UIButton){
        
        NavigateToHome.sharedd.navigate(naviagtionC: self.navigationController!)
    }
    
    @IBAction func addAddress(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddAddressVC") as! AddAddressVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func editAddress(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddAddressVC") as! AddAddressVC
        vc.key = "Edit"
        vc.addressId = addressData[sender.tag]["_id"] as! String
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func removeAddress(_ sender: UIButton){
    }
    @IBAction func setDefault(_ sender: UIButton){
    }
    @IBAction func backTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func selectAddress(_ sender: UIButton){
        addressTable.reloadData()
        print(count)
        if count == 0{
            count = 1
            
        }else{
            count = 0
        }
    }
    
}

extension AddressVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = addressTable.dequeueReusableCell(withIdentifier: "cell") as! AddressTableCell
        ///
        cell.viewTable.layer.cornerRadius = 10
        cell.viewTable.layer.borderWidth = 1
        cell.viewTable.layer.borderColor = UIColor.lightGray.cgColor
        ///
        cell.editBtn.layer.cornerRadius = 5
        cell.editBtn.layer.borderWidth = 1
        cell.editBtn.layer.borderColor = UIColor.lightGray.cgColor
        ///
        cell.remove.layer.cornerRadius = 5
        cell.remove.layer.borderWidth = 1
        cell.remove.layer.borderColor = UIColor.lightGray.cgColor
        ///
        cell.setDefault.layer.cornerRadius = 5
        cell.setDefault.layer.borderWidth = 1
        cell.setDefault.layer.borderColor = UIColor.lightGray.cgColor
        ///
        cell.editBtn.tag = indexPath.row
        cell.remove.tag = indexPath.row
        cell.setDefault.tag = indexPath.row
        cell.selectBtn.tag = indexPath.row
        ///
        print(addressData)
        cell.name.text = addressData[indexPath.row]["fullName"] as? String ?? ""
        cell.mobile.text = addressData[indexPath.row]["mobileNo"] as? String ?? ""
        cell.address.text = "\(addressData[indexPath.row]["buildingNo"] as?  String ?? ""),\(addressData[indexPath.row]["street"] as? String ?? ""),\(addressData[indexPath.row]["city"] as? String ?? ""),\(addressData[indexPath.row]["state"] as? String ?? ""),Near\(addressData[indexPath.row]["area"] as? String ?? "")"
       ///
        if self.count == 0{
            cell.selectBtn.setImage(UIImage(named: "addressSelected"), for: .normal)
        }else{
            cell.selectBtn.setImage(UIImage(named: "selectAddress"), for: .normal)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if key == "cart"{
            let vc = storyboard?.instantiateViewController(withIdentifier: "CheckoutVC") as! CheckoutVC
            vc.addressId = addressData[indexPath.row]["_id"] as! String
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

class AddressTableCell: UITableViewCell{
    
    @IBOutlet weak var viewTable: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var remove: UIButton!
    @IBOutlet weak var setDefault: UIButton!
    
    
}
