//
//  ProfileVC.swift
//  TheMallApp
//
//  Created by mac on 10/02/2022.
//

import UIKit
import Alamofire
import AlamofireImage
import ARSLineProgress

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
    
    let tabData = ["Change password","My orders","Address","Log out", "Delete Account"]
    var data : NSDictionary!
    var userId = ""
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        userId = UserDefaults.standard.value(forKey: "id") as? String ?? ""
        if userId != ""{
            ARSLineProgress.show()
            getProfile { isSuccess in
                ARSLineProgress.hide()
                if isSuccess {
                    self.nameLabel.text = self.data.object(forKey: "name") as! String
                    self.contactLabel.text = self.data.object(forKey: "email") as! String
                    if let image = self.data.object(forKey: "profileImageName") as? String{
                        DispatchQueue.main.async {
                            print(image)
                            let url = URL(string: image)
                            print("sdfsadf",url)
                            if url != nil{
                                self.pic.af.setImage(withURL: url!)
                            }else{
                                print("hello")
                            }
                        }
                    }
                }else{
                    print("message")
                }
            }

        }else{
            self.showAlertWithOneAction(alertTitle: "Oops!", message: "You are not logged in please login to continue", action1Title: "OK") { isSuccess in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                self.navigationController?.pushViewController(vc, animated: false)
        }
        
    }
    
    }

    @IBAction func addProfileBtn(_ sender: Any) {
        openCameraAndPhotos(isEditImage: true) { [self] image, string in
            self.pic.image = image.withRenderingMode(.alwaysOriginal)
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
        case 1:
            let vc = storyboard?.instantiateViewController(withIdentifier: "MyOrdersVC") as! MyOrdersVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = storyboard?.instantiateViewController(withIdentifier: "AddressVC") as! AddressVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            UserDefaults.standard.removeObject(forKey: "id")
            UserDefaults.standard.removeObject(forKey: "token")
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            self.showAlertWithTwoActions(alertTitle: "Delete Account", message: "Your account will be permanantly removed from app you have to register again are you sure you want to delete account?", action1Title: "Yes", action1Style: .destructive, action2Title: "Cancel") { yes in
                
                let userid = UserDefaults.standard.value(forKey: "id") as! String
                let token = UserDefaults.standard.value(forKey: "token") as! String
                ApiManager.shared.deleteUser(userid: userid, token: token) { isSuccess in
                    if isSuccess{
                        UserDefaults.standard.removeObject(forKey: "id")
                        UserDefaults.standard.removeObject(forKey: "token")
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else{
                        self.alert(message: ApiManager.shared.msg)
                    }
                }
                
            } completion2: { cancel in
                print("Hello")
            }

            
        default:
            print("Functionality under developement")
        }
    }
    
}


extension ProfileVC{
    func getProfile(completion: @escaping (Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
        
            AF.request(Api.getProfile+userId,method: .get,encoding: JSONEncoding.default).responseJSON {[self]
            response in
            switch(response.result){
                
            case .success(let json):do{
                let success = response.response?.statusCode
                let respond = json as! NSDictionary
                if success == 200{
                    print("success",respond)
                    data = respond.object(forKey: "data") as! NSDictionary
                    completion(true)
                }else{
                    completion(false)
                }
            }
                
            case .failure(let error): do{
                print("error",error)
                completion(false)
            }
                
            }
        }
        }else{
            completion(false)
        }
    }

}
