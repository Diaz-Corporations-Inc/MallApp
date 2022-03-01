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
    override func viewDidLoad() {
        super.viewDidLoad()
        if a == ""{
            backbtn.isHidden = true
        }else{
            backbtn.isHidden = false
        }
    }
    
    @IBAction func detailTapped(_ sender: Any) {
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
        return cell
    }
    
    
}
