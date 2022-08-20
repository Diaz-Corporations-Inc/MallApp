//
//  DealsOfDayVC.swift
//  TheMallApp
//
//  Created by mac on 09/02/2022.
//

import UIKit
import AlamofireImage
import ARSLineProgress

class DealsOfDayVC: UIViewController {

    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var dealsCollection: UICollectionView!
    @IBOutlet weak var promoCollection: UICollectionView!
    @IBOutlet weak var oldDealsCollection: UICollectionView!
    var key = ""
    var data = [AnyObject]()
    var oldData = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getDeals()
        
        
    }
//    func set(){
//        print(data.count)
//        for i in 0...data.count-1{
//            print(i,"sadfdsfdasf")
//            if let halfcount = data.count/2 as? Int{
//                print(halfcount)
//                break
//            }
//            print(i,"sdsdsds")
//        }
//    }
    @IBAction func mallLogoTapped(_ sender: Any) {
        NavigateToHome.sharedd.navigate(naviagtionC: self.navigationController!)
    }
    @IBAction func contactUsTapped(_ sender: Any) {
        guard let url = URL(string: "https://mymallapp.co/support/.") else {return}
        UIApplication.shared.openURL(url)
    }
    @IBAction func registerTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ListingTypeVC") as! ListingTypeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DealsOfDayVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dealsCollection{
            let cell = dealsCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DealsCollCell
            cell.collView.layer.shadowColor = UIColor.gray.cgColor
            cell.collView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cell.collView.layer.shadowRadius = 1
            cell.collView.layer.shadowOpacity = 5
            cell.productName.text = self.data[indexPath.row]["name"] as! String
            if let gallery = self.data[indexPath.row]["gallery"] as? [AnyObject]{
                if gallery.count != 0{
                    if let image = gallery[0]["name"] as? String{
                        let url = URL(string: "http://93.188.167.68/projects/mymall_nodejs/assets/images/\(image)")
                        if url != nil{
                            cell.productImage.af.setImage(withURL: url!)
                        }else{
                            print("hello")
                        }
                        
                    }
                }

                }
                            return cell
        }else{
            let cell = oldDealsCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OldDealCollCell
            cell.oldDealView.layer.borderColor = UIColor.gray.cgColor
            cell.oldDealView.layer.borderWidth = 1
            cell.oldDealView.layer.shadowColor = UIColor.gray.cgColor
            cell.oldDealView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cell.oldDealView.layer.shadowRadius = 1
            cell.oldDealView.layer.shadowOpacity = 5
            cell.productname.text = self.data[indexPath.row]["name"] as! String
            if let gallery = self.data[indexPath.row]["gallery"] as? [AnyObject]{
                if gallery.count != 0{
                    if let image = gallery[0]["name"] as? String{
                        let url = URL(string: "http://93.188.167.68/projects/mymall_nodejs/assets/images/\(image)")
                        if url != nil{
                            cell.imageOld.af.setImage(withURL: url!)
                        }else{
                            print("hello")
                        }
                    }
                }
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == oldDealsCollection{
            return CGSize(width: oldDealsCollection.frame.width/3, height: oldDealsCollection.frame.height)
        }else if collectionView == promoCollection{
            return CGSize(width: promoCollection.frame.width/1.3, height: promoCollection.frame.height)

        }else{
            return CGSize(width: dealsCollection.frame.width/3, height: dealsCollection.frame.height/2)

        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
            vc.productId = self.data[indexPath.item]["_id"] as! String
            self.navigationController?.pushViewController(vc, animated: true)
       
       
    }
    
}


extension DealsOfDayVC{
    func getDeals(){
        ARSLineProgress.show()
        ApiManager.shared.dealsOfTheDay {[self] isSuccess in
            ARSLineProgress.hide()
            if isSuccess{
                ARSLineProgress.hide()
                self.data = ApiManager.shared.data
                dealsCollection.reloadData()
                oldDealsCollection.reloadData()
//                set()
                
            }else{
                ARSLineProgress.hide()
                self.alert(message: ApiManager.shared.msg)            }
        }
    }
}
