//
//  SideMenu.swift
//  TheMallApp
//
//  Created by Macbook on 07/03/22.
//

import UIKit

class SideMenu: UIViewController {
    
    let a : String? = "b"
    let defaults = UserDefaults.standard

    @IBOutlet weak var sidemenuTable: UITableView!{
        didSet{
            sidemenuTable.tableFooterView = UIView(frame: .zero)
        }
    }

    var sideArray = ["Favourite","Deals","Near shop","Register store","Privacy Policy","Contact Us"]
    var userArray = ["Favourite","Deals","Near shop","Privacy Policy","Contact Us"]


    let sideImage = [UIImage(named: "s1"),UIImage(named: "s5"),UIImage(named: "s2"),UIImage(named: "s3"),UIImage(named: "s3"),UIImage(named: "s4")]
    let userImage = [UIImage(named: "s1"),UIImage(named: "s5"),UIImage(named: "s2"),UIImage(named: "s3"),UIImage(named: "s4")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello")
    }
    
    @IBAction func signOutTapped(_ sender: Any) {
        
    }
    
 
}

class SideMenuCell: UITableViewCell{
    @IBOutlet weak var sideImage: UIImageView!
    @IBOutlet weak var sideLabel: UILabel!
    
}

extension SideMenu: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //if defaults.value(forKey: "Role") as! String == "User"{
          //  return userArray.count
        //}else{
            return sideArray.count
        //}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sidemenuTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SideMenuCell
        //if defaults.value(forKey: "Role") as! String == "User"{
          ///  cell.sideLabel.text = userArray[indexPath.row]
            cell.sideImage.image = sideImage[indexPath.row]
        //}else{
            cell.sideLabel.text = sideArray[indexPath.row]
           // cell.sideImage.image = sideImage[indexPath.row]
      //  }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        switch indexPath.row{
            
        case 0:
            let vc = story.instantiateViewController(withIdentifier: "FavoutiteVC") as! FavoutiteVC
            vc.a = "s"
            let navigationController = UINavigationController.init(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.isNavigationBarHidden = true
            self.present(navigationController, animated: true, completion: nil)

        case 1:
            let vc = story.instantiateViewController(withIdentifier: "DealsOfDayVC") as! DealsOfDayVC
            vc.key = "S"
             let navigationController = UINavigationController.init(rootViewController: vc)
             navigationController.modalPresentationStyle = .fullScreen
             navigationController.isNavigationBarHidden = true
            self.present(navigationController, animated: true, completion: nil)
        case 2:
            let vc = story.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
            vc.key = "S"
            let navigationController = UINavigationController.init(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.isNavigationBarHidden = true
           self.present(navigationController, animated: true, completion: nil)

        case 3:
            let vc = story.instantiateViewController(withIdentifier: "ListingTypeVC") as! ListingTypeVC
            vc.key = "S"
            let navigationController = UINavigationController.init(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.isNavigationBarHidden = true
           self.present(navigationController, animated: true, completion: nil)

        case 4:
          alert(message: "")

        default:
            print("sdbvus")
        }
    }
    
}
