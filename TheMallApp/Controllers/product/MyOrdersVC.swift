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
    
    var orderData = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterView.layer.borderColor = UIColor.lightGray.cgColor
        filterView.layer.cornerRadius = 5
        filterView.layer.borderWidth = 1
        getOrder()
    }
    

    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func mallLogoTapped(_ sender: Any) {
        NavigateToHome.sharedd.navigate(naviagtionC: self.navigationController!)
    }
    @IBAction func helpTapped(_ sender: UIButton) {
        
    }
    @IBAction func cancelTapped(_ sender: UIButton) {
        
    }
    
    
}


extension MyOrdersVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderTable.dequeueReusableCell(withIdentifier: "cell") as! OrderCell
        cell.productStatus.text = orderData[indexPath.row]["status"] as! String
        cell.orderDate.text = "Order id :- \(orderData[indexPath.row]["_id"] as! String)"
        cell.productName.text = "Amount paid $\(orderData[indexPath.row]["totalAmount"] as! Double)"
        cell.productBrand.text = "Payment status:- \(orderData[indexPath.row]["paymentStatus"] as! String)"
        return cell
    }
    
    
}
class OrderCell: UITableViewCell{
    @IBOutlet weak var productBrand: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productStatus: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var helpBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
}

extension MyOrdersVC{
    func getOrder(){
        ApiManager.shared.getOrders { isSuccess in
            if isSuccess{
                print("hello")
                self.orderData = ApiManager.shared.data
                self.orderTable.reloadData()
            }else{
                self.alert(message: ApiManager.shared.msg)
            }
        }
    }
}
