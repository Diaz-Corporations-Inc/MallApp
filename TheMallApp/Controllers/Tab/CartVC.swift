//
//  CartVC.swift
//  TheMallApp
//
//  Created by mac on 09/02/2022.
//

import UIKit

class CartVC: UIViewController {

    
    
    @IBOutlet weak var cartTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    


}

class CartTablecell: UITableViewCell{
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var name: UILabel!
}


extension CartVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTable.dequeueReusableCell(withIdentifier: "cell") as! CartTablecell
        return cell
    }
    
    
}
