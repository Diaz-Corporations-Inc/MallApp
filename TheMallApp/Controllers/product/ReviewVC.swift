//
//  ReviewVC.swift
//  TheMallApp
//
//  Created by Macbook Air (ios) on 21/04/22.
//

import UIKit
import Cosmos

class ReviewVC: UIViewController {

    @IBOutlet weak var reviewTable: UITableView!
    @IBOutlet weak var ratingView: CosmosView!
    
  
    var reviewArray = [AnyObject]()
    var productData = NSDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reviewArray = productData.object(forKey: "rating") as! [AnyObject]
    }
    
    @IBAction func backTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func mallLogoTapped(_ sender: Any) {
        NavigateToHome.sharedd.navigate(naviagtionC: self.navigationController!)
    }
}

extension ReviewVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reviewTable.dequeueReusableCell(withIdentifier: "cell") as! ReviewCell
        let rating = productData.object(forKey: "rating") as! [AnyObject]
        print("sdsd",rating)
        if rating.count != 0{
            print(rating)
            cell.review.text = rating[indexPath.row]["review"] as! String
            let date = rating[indexPath.row]["postedOn"] as! String
            print(date)
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss:SSS'Z'"
           let datt = dateFormat.date(from: date)
            dateFormat.dateStyle = .medium
            print("dfnvjdfbvksdfkv",datt)
            
            cell.dateTime.text = dateFormat.string(from: datt ?? Date())
//            ratingView.rating = rating[indexPath.row]["rating"] as! Double
            cell.userName.text = rating[indexPath.row]["customerName"] as! String
        }
//        cell.review.text = reviewArray[indexPath.row]["review"] as! String
//        cell.userName.text = reviewArray[indexPath.row]["customerName"] as! String
////        ratingView.rating = reviewArray[indexPath.row]["rating"] as! Double
//        cell.dateTime.text = reviewArray[indexPath.row]["postedOn"]as! String
        return cell
    }
    
    
}
