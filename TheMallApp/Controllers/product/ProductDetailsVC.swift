//
//  ProductDetailsVC.swift
//  TheMallApp
//
//  Created by mac on 11/02/2022.
//

import UIKit
import AlamofireImage

class ProductDetailsVC: UIViewController,UIPageViewControllerDelegate {

    @IBOutlet weak var reviewStars: UIView!
    @IBOutlet weak var picCollection: UICollectionView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var colorCollection: UICollectionView!
    @IBOutlet weak var sizeCollection: UICollectionView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var reviewerName: UILabel!
    @IBOutlet weak var reviewdate: UILabel!
    @IBOutlet weak var review: UILabel!
    @IBOutlet weak var ratingStars: UIView!
    @IBOutlet weak var similarProduct: UICollectionView!
    @IBOutlet weak var addFavourite: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var editProduct: UIButton!
    @IBOutlet weak var addReview: UITextField!
    
    var productId = ""
    var productData : NSDictionary!
    let sizeArray = ["M","L","XL","XXL"]
    let color = ["Blue","Black","Green","Grey"]
    var storeId = ""
    var userId = ""
    var key = ""
    var masterTotal = Int()
    var gallery = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getProductDetail()
        if key == "My"{
            editProduct.isHidden = false
        }else{
            editProduct.isHidden = true
        }
        self.similarProduct.delegate = self
        self.similarProduct.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        userId = UserDefaults.standard.value(forKey: "id") as? String ?? ""
    }
    func getData(){
        storeId = productData.object(forKey: "store") as! String
        masterTotal = productData.object(forKey: "masterPrice") as! Int
        if let gall = productData.object(forKey: "gallery") as? [AnyObject]{
            gallery = gall
        }
       
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl?.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    @IBAction func viewAllTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ReviewVC") as! ReviewVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func addReviewTapped(_ sender: UIButton){
        review.text = addReview.text
        let date = Date()
        let dateFormet = DateFormatter()
        dateFormet.dateStyle = .full
        self.reviewdate.text = "\(dateFormet.string(from: date))"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            self.addReview.text = ""
        }
     
    }
    @IBAction func editTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddProductVC") as! AddProductVC
        vc.key = "Edit"
        vc.productData = self.productData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addToFavourite(_ sender: Any) {
        if userId == ""{
            self.showAlertWithOneAction(alertTitle: "Oops!", message: "You are not logged in please login to continue", action1Title: "OK") { isSuccess in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                self.navigationController?.pushViewController(vc, animated: false)
            }
        }else{
            let params : [String:Any] = ["userId":userId,"productId": self.productId,"storeId":"\(storeId)","quantity":"1","total": "\(masterTotal)","status":"Cart"]
            print(params)
            ApiManager.shared.addToCart(params) { isSuccess  in
                if isSuccess{
                
                    self.alert(message: ApiManager.shared.msg)
                }else{
                
                    self.alert(message: ApiManager.shared.msg)
                }
            }
        }
    }
}

extension ProductDetailsVC{
    func getProductDetail(){
        ApiManager.shared.getProductById(productId: productId) { [self] isSuccess in
            if isSuccess{
                productData = ApiManager.shared.dataDict
                print(productData)
                setData()
               
            }else{
                print("wrong url")
            }
        }
    }
    func setData(){
        productName.text = productData.object(forKey: "name") as! String
        detailLabel.text = productData.object(forKey: "description") as! String
        price.text = "$ \(productData.object(forKey: "masterPrice") as! Int)"
        picCollection.reloadData()
        colorCollection.reloadData()
        similarProduct.reloadData()
        getData()
    }
}
extension ProductDetailsVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sizeCollection{
            return sizeArray.count
        }else {
            pageControl.numberOfPages = gallery.count
                pageControl.isHidden = !(gallery.count > 1)
            return gallery.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == picCollection{
            let cell = picCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCollcell
            pageControl.currentPage = indexPath.item
            if let image = gallery[indexPath.row]["name"] as? String{
                let url = URL(string: image)
                if url != nil{
                    cell.productImage.af.setImage(withURL: url!)
                }else{
                    cell.productImage.image = UIImage(named: "")
                }
            }
            return cell
        }else if collectionView == colorCollection{
            let cell = colorCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductColor
            cell.colorView.layer.borderWidth = 1
            cell.colorView.layer.borderColor = UIColor.gray.cgColor
            if let image = gallery[indexPath.row]["name"] as? String{
                let url = URL(string: image)
                if url != nil{
                    cell.colorImage.af.setImage(withURL: url!)
                }else{
                    cell.colorImage.image = UIImage(named: "")
                }
            }
            return cell
        }else if collectionView == sizeCollection{
            let cell = sizeCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductSize
            cell.sizeLabel.text = sizeArray[indexPath.row]
            cell.sizeView.layer.borderWidth = 1
            cell.sizeView.layer.borderColor = UIColor.gray.cgColor
            return cell
        }
        else{
            let cell = similarProduct.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SimilarCollCell
            cell.similarView.layer.shadowColor = UIColor.gray.cgColor
            cell.similarView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cell.similarView.layer.shadowRadius = 1
            cell.similarView.layer.shadowOpacity = 10
            cell.similarView.layer.cornerRadius = 20
            cell.similarPic.layer.cornerRadius = 20
            cell.similarPic.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == picCollection{
            return CGSize(width: picCollection.frame.width, height: picCollection.frame.height)
        }else if collectionView == colorCollection{
            return CGSize(width: colorCollection.frame.width/5, height: colorCollection.frame.height)
        }else if collectionView == sizeCollection{
            return CGSize(width: sizeCollection.frame.width/5, height: sizeCollection.frame.height)
        }else{
                return CGSize(width: similarProduct.frame.width/2, height: similarProduct.frame.height)
            
        }
    }
}

class ProductCollcell: UICollectionViewCell{
    
    @IBOutlet weak var productImage: UIImageView!
}

class ProductColor: UICollectionViewCell{
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorImage: UIImageView!

    override func awakeFromNib() {
        
    }
    
}

class ProductSize: UICollectionViewCell{
    @IBOutlet weak var sizeView: UIView!
    @IBOutlet weak var sizeLabel: UILabel!
    override  func awakeFromNib() {
       
    }
    
}

class SimilarCollCell: UICollectionViewCell{
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var similarPic: UIImageView!
    @IBOutlet weak var similarView: UIView!
    @IBOutlet weak var starProduct: UIView!
    
    override func awakeFromNib() {
        
        
        
    }
}
