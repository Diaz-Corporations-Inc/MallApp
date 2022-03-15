//
//  BrowseAllVC.swift
//  TheMallApp
//
//  Created by mac on 08/02/2022.
//

import UIKit

class BrowseAllVC: UIViewController {

    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var browseTable: UITableView!
    var a = ""
    
    var selectedRows:[IndexPath] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if a == ""{
            backbtn.isHidden = true
        }else{
            backbtn.isHidden = false
        }
    }
    
    
    @IBAction func likeTapped(_ sender: UIButton) {
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
    @IBAction func detailTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StoreVC") as! StoreVC
        vc.key = "df"
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
    }
}

extension BrowseAllVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = browseTable.dequeueReusableCell(withIdentifier: "cell") as! BrowseCell
        
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
    
    
}
