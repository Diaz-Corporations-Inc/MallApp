//
//  SearchVC.swift
//  TheMallApp
//
//  Created by Macbook Air (ios) on 03/05/22.
//

import UIKit

class SearchVC: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var serachTextField: UITextField!
    @IBOutlet weak var serachTable: UITableView!{
        didSet{
            serachTable.tableFooterView = UIView(frame: .zero)
        }
    }
    
    var dataa = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serachTextField.delegate = self
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        ApiManager.shared.searchStore(storename: serachTextField.text!) { isSuccess in
            if isSuccess{
                self.dataa = ApiManager.shared.data
                self.serachTable.reloadData()
                if self.dataa.isEmpty{
                    self.serachTable.isHidden = true
                }else{
                    self.serachTable.isHidden = false
                }
            }else{
                print("hello")
            }
        }
    }
    @IBAction func SearchTapped(_ sender: UIButton){
        ApiManager.shared.searchStore(storename: serachTextField.text!) { isSuccess in
            if isSuccess{
                self.dataa = ApiManager.shared.data
                self.serachTable.reloadData()
                if self.dataa.isEmpty{
                    self.serachTable.isHidden = true
                }else{
                    self.serachTable.isHidden = false
                }
            }else{
                print("hello")
            }
        }
    }
    @IBAction func backTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: false)
    }

}

class SearchTableCell: UITableViewCell{
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeDescription: UILabel!
    
}

extension SearchVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataa.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = serachTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableCell
        cell.storeName.text = dataa[indexPath.row]["name"] as! String
        cell.storeDescription.text = dataa[indexPath.row]["description"] as! String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "StoreVC") as! StoreVC
        vc.storeId = dataa[indexPath.row]["_id"] as! String
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
