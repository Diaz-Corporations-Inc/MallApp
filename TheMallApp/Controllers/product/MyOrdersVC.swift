//
//  MyOrdersVC.swift
//  TheMallApp
//
//  Created by Macbook Air (ios) on 26/04/22.
//

import UIKit

class MyOrdersVC: UIViewController {

    
    
    @IBOutlet weak var orderTable: UITableView!
    @IBOutlet weak var filterView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterView.layer.borderColor = UIColor.lightGray.cgColor
        filterView.layer.cornerRadius = 5
        filterView.layer.borderWidth = 1
    }
    

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func mallLogoTapped(_ sender: Any) {
        NavigateToHome.sharedd.navigate(naviagtionC: self.navigationController!)
    }
    
}


extension MyOrdersVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderTable.dequeueReusableCell(withIdentifier: "cell") as! OrderCell
        return cell
    }
    
    
}
class OrderCell: UITableViewCell{
    
}

extension MyOrdersVC{
    
}
