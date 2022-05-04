//
//  ReviewVC.swift
//  TheMallApp
//
//  Created by Macbook Air (ios) on 21/04/22.
//

import UIKit

class ReviewVC: UIViewController {

    @IBOutlet weak var reviewTable: UITableView!
    
    var nameArray = ["Anish","Anila","Josh","John"]
    var dateTime = ["Tue 10:30 AM","Mon 11:30 AM","Thu 12:30 PM","Tue 01:30 PM"]
    var review = ["Nice product","Great product","Nice","Good, i will recommend to buy this product"]
    var productData = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func backTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}

extension ReviewVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reviewTable.dequeueReusableCell(withIdentifier: "cell") as! ReviewCell
//        let rating = productData.object(forKey: "rating") as! [AnyObject]
//        print("sdsd",rating)
//        if rating.count != 0{
//            print(rating)
//            cell.review.text = rating[indexPath.row]["review"] as! String
//            let date = rating[indexPath.row]["postedOn"] as! String
//            print(date)
//            let dateFormat = DateFormatter()
//            dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss:SSS'Z'"
//           let datt = dateFormat.date(from: date)
//            dateFormat.dateStyle = .medium
//            print("dfnvjdfbvksdfkv",datt)
//            cell.dateTime.text = dateFormat.string(from: datt ?? Date())
//            cell.userName.text = rating[indexPath.row]["customerName"] as! String
//        }
        cell.review.text = review[indexPath.row]
        cell.userName.text = nameArray[indexPath.row]
        cell.dateTime.text = dateTime[indexPath.row]
        return cell
    }
    
    
}
