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

    var sideArray = ["Cart","Favorite","Deals","Near shop","My store","Shop by category","Privacy Policy","Contact Us"]
    var userArray = ["Cart","Favorite","Deals","Near shop","Shop by category","Privacy Policy","Contact Us"]


    let sideImage = [UIImage(named: "cartactive"),UIImage(named: "s1"),UIImage(named: "s5"),UIImage(named: "s2"),UIImage(named: "s3"),UIImage(named: "s3"),UIImage(named: "s3"),UIImage(named: "s4")]
    let userImage = [UIImage(named: "s1"),UIImage(named: "s5"),UIImage(named: "s2"),UIImage(named: "s3"),UIImage(named: "s4")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello")
        backColor()
    }
    
    func backColor(){
                    let upColor = UIColor(red: 80/255,green: 226/255,blue: 168/255,alpha: 1.0).cgColor
                    let downColor = UIColor(red: 75/255,green: 116/255,blue: 159/255,alpha: 1.0).cgColor
                    let gradient = CAGradientLayer()
                    gradient.colors = [upColor,downColor]
                    gradient.locations = [0.4,1.0]
                    gradient.frame = self.view.bounds
                    self.view.layer.insertSublayer(gradient, at: 0)
    }
    @IBAction func signOutTapped(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "token")
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        let navigationController = UINavigationController.init(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.isNavigationBarHidden = true
        self.present(navigationController, animated: true, completion: nil)
        
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
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        switch indexPath.row{
            
        case 0:
            
            let vc = story.instantiateViewController(withIdentifier: "CartVC") as! CartVC
            vc.key = "s"
            let navigationController = UINavigationController.init(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.isNavigationBarHidden = true
            self.present(navigationController, animated: true, completion: nil)
            
        case 1:
            let vc = story.instantiateViewController(withIdentifier: "FavoutiteVC") as! FavoutiteVC
            vc.a = "s"
            let navigationController = UINavigationController.init(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.isNavigationBarHidden = true
            self.present(navigationController, animated: true, completion: nil)
        case 2:
            let vc = story.instantiateViewController(withIdentifier: "DealsOfDayVC") as! DealsOfDayVC
            vc.key = "S"
             let navigationController = UINavigationController.init(rootViewController: vc)
             navigationController.modalPresentationStyle = .fullScreen
             navigationController.isNavigationBarHidden = true
            self.present(navigationController, animated: true, completion: nil)
        case 3:
            let vc = story.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
            vc.key = "S"
            let navigationController = UINavigationController.init(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.isNavigationBarHidden = true
           self.present(navigationController, animated: true, completion: nil)

        case 4:
            let vc = story.instantiateViewController(withIdentifier: "StoreVC") as! StoreVC
            vc.key = "My"
            let navigationController = UINavigationController.init(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.isNavigationBarHidden = true
           self.present(navigationController, animated: true, completion: nil)

        case 5:
            let vc = story.instantiateViewController(withIdentifier: "BrowseAllVC") as! BrowseAllVC
            vc.a = "2"
            let navigationController = UINavigationController.init(rootViewController: vc)
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.isNavigationBarHidden = true
           self.present(navigationController, animated: true, completion: nil)
            
        case 6:
            guard let url = URL(string: "https://mymallapp.co/wpautoterms/privacy-policy/") else {return}
            UIApplication.shared.openURL(url)
//        https://mymallapp.co/wpautoterms/privacy-policy/
        case 7:
            guard let url = URL(string: "https://mymallapp.co/support/.") else {return}
            UIApplication.shared.openURL(url)
//        https://mymallapp.co/support/.
        default:
            print("sdbvus")
        }
    }
    
}
