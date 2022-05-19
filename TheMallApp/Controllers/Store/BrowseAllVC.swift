//
//  BrowseAllVC.swift
//  TheMallApp
//
//  Created by mac on 08/02/2022.
//

import UIKit
import ARSLineProgress
import DropDown
class BrowseAllVC: UIViewController {

    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var browseTable: UITableView!
    @IBOutlet weak var selectCategory: UILabel!
    @IBOutlet weak var nearYouTop: NSLayoutConstraint!
    ///
    var drop = DropDown()
    ///
    var a = ""
    var storeId = ""
    var userId = ""
    ///
    var filterArray = ["All"]
    var categoryId = ["All"]
    var selectedRows:[IndexPath] = []
    var storeData = [AnyObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        browseTable.delegate = self
        browseTable.dataSource = self
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        userId = UserDefaults.standard.value(forKey: "id") as? String ?? ""

        setData()
        getCategory()
        if a == ""{
            backbtn.isHidden = true
        }else{
            backbtn.isHidden = false
        }
    }
    
    func setData(){
        if userId == ""{
            ARSLineProgress.show()
            ApiManager.shared.storeList { [self] isSuccess in
                ARSLineProgress.hide()
                if isSuccess{
                    storeData.removeAll()
                    storeData = ApiManager.shared.data
                    if storeData.count == 0{
                        nearYouTop.constant = -150
                    }else{
                        nearYouTop.constant = 10
                    }
                    browseTable.reloadData()
                }else{
                    print("hello")
                }
            }
        }else{
            ARSLineProgress.show()
            ApiManager.shared.storeListWithTOken{ [self] isSuccess in
                ARSLineProgress.hide()
                if isSuccess{
                    storeData.removeAll()
                    storeData = ApiManager.shared.data
                    if storeData.count == 0{
                        nearYouTop.constant = -150
                    }else{
                        nearYouTop.constant = 10
                    }
                    browseTable.reloadData()
                }else{
                    print("hello")
                }
            }
        }
       
    }
    func getCategory(){
        ARSLineProgress.show()
        ApiManager.shared.getCategories { [self] isSuccess in
            ARSLineProgress.hide()
            if isSuccess{
                let data = ApiManager.shared.data
                for i in 0...data.count-1{
                    filterArray.append(data[i]["name"] as! String)
                    categoryId.append(data[i]["_id"] as! String)
                
                }
                print("asdfsdafasdfsadf",categoryId,filterArray,"sdfsdafsadfsadfasdfsdf")
            }else{
                alert(message: ApiManager.shared.msg)
            }
        }
    }
    
   ///
    @IBAction func mallLogoTapped(_ sender: Any) {
        NavigateToHome.sharedd.navigate(naviagtionC: self.navigationController!)
    }
    ///
    @IBAction func selectCat(_ sender:UIButton){
        drop.dataSource = filterArray
        drop.anchorView = browseTable
        drop.show()
        drop.selectionAction = { [unowned self] (index, item) in
            selectCategory.text = item
            if filterArray[index] == "All"{
                setData()
            }else{
                ApiManager.shared.storeByCategory(categoryId: self.categoryId[index]) { isSuccess in
                    if isSuccess{
                        print(storeData.count,"dsfe")
                        storeData.removeAll()
                        print(storeData.count,"dsfesfdsda")
                        storeData = ApiManager.shared.data
                        print(storeData.count,"dsfesfdsda")
                        if storeData.count == 0{
                            nearYouTop.constant = -150
                        }else{
                            nearYouTop.constant = 10
                        }
                        browseTable.reloadData()
                        
                    }else{
                        print(ApiManager.shared.msg)
                    }
                }
            }
            
            drop.hide()
        }
    }
    @IBAction func likeTapped(_ sender: UIButton) {
        if userId == ""{
            self.showAlertWithOneAction(alertTitle: "Oops!", message: "You are not logged in please login to continue", action1Title: "OK") { isSuccess in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }else{
            storeId = storeData[sender.tag]["_id"] as! String
            let favModel = favouriteModel(userId: userId, storeId: storeId)
            ApiManager.shared.favUnFav(model: favModel) { isSuccess in
                if isSuccess{
                    print("success")
                    self.setData()
                }else{
                    print("success")
                }
            }
    }
    }
   
    @IBAction func backTapped(_ sender: Any) {
        if a == "2"{
            self.dismiss(animated: true, completion: nil)
        }else{
            navigationController?.popViewController(animated: true)
        }
        
    }
    @IBAction func browseNearYou(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
        vc.key = "B"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension BrowseAllVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = browseTable.dequeueReusableCell(withIdentifier: "cell") as! BrowseCell
       
        cell.likeBtn.tag = indexPath.row
        cell.likeBtn.setImage(UIImage(named: "likeInactive"), for: .normal)
        cell.storeName.text = storeData[indexPath.row]["name"] as! String
        cell.available.text = storeData[indexPath.row]["description"] as! String
        
        if let image = storeData[indexPath.row]["logo"] as? String{
            let url = URL(string: "http://93.188.167.68/projects/mymall_nodejs/assets/images/\(image)")
            if url != nil{
                cell.cellImage.af.setImage(withURL: url!)
            }else{
                cell.cellImage.image = UIImage(named: "c2")
            }
        }
        
        guard let isFav = storeData[indexPath.row]["isFav"] as? Bool else{return cell}
        if isFav == true{
            cell.likeBtn.setImage(UIImage(named: "likeActive"), for: .normal)
        }else{
            cell.likeBtn.setImage(UIImage(named: "likeInactive"), for: .normal)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        print("jhcgfdxgfnchjvcgfndzngh")
        let vc = storyboard?.instantiateViewController(withIdentifier: "StoreVC") as! StoreVC
        vc.storeId = storeData[indexPath.row]["_id"] as! String
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
