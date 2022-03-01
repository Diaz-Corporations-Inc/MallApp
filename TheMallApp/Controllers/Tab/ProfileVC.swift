//
//  ProfileVC.swift
//  TheMallApp
//
//  Created by mac on 10/02/2022.
//

import UIKit


class ProfileVC: BaseClass {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var membershipName: UILabel!
    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var subscriptionTime: UILabel!
    @IBOutlet weak var proTable: UITableView!{
        didSet{
            proTable.tableFooterView = UIView(frame: .zero)
        }
    }
    
    let tabData = ["Change password","Log out", "Logout from all devices"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func addProfileBtn(_ sender: Any) {
        openCameraAndPhotos(isEditImage: false) { [self] image, string in
            self.pic.image = image
            ApiManager.shared.upload(
                image: self.pic.image!,
                        progressCompletion: { [weak self] percent in
                           guard let _ = self else {
                             return
                           }
                           print("Status: \(percent)")
                          if percent == 1.0{
                         self!.alert(message: "Profile updated Successfully", title: "Image")
                               
                           }
                         },
                         completion: { [weak self] result in
                           guard let _ = self else {
                             return
                           }
                       })
        } failure: { Error in
            print(Error)
        }
    }
    
    
    @IBAction func upgradeBtn(_ sender: Any) {
    }
}




extension ProfileVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tabData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = proTable.dequeueReusableCell(withIdentifier: "cell") as! ProTableCell
        cell.cellLabel.text = tabData[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("Functionality under developement")
        }
    }
    
}

