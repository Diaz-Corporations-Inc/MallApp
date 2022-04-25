//
//  NotificationVC.swift
//  TheMallApp
//
//  Created by Macbook Air (ios) on 13/04/22.
//

import UIKit

class NotificationVC: UIViewController {

    @IBOutlet weak var notificationTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}

class notificationTableCell:UITableViewCell{
    
    @IBOutlet weak var notificationTime: UILabel!
    @IBOutlet weak var notificationMessage: UILabel!
    @IBOutlet weak var notificationName: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
}

extension NotificationVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notificationTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! notificationTableCell
        return cell
    }
    
    
}

