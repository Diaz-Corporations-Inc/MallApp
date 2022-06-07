//
//  ProductDetailsVC.swift
//  TheMallApp
//
//  Created by mac on 11/02/2022.
//

import UIKit
import AlamofireImage
import Cosmos

class ProductDetailsVC: UIViewController,UIPageViewControllerDelegate {

    @IBOutlet weak var cosmosRating: CosmosView!
    @IBOutlet var ratingView: CosmosView!
    @IBOutlet weak var reviewStars: CosmosView!
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
    @IBOutlet weak var ratingStars: CosmosView!
    @IBOutlet weak var similarProduct: UICollectionView!
    @IBOutlet weak var addFavourite: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var editProduct: UIButton!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var priceLast: UILabel!
    
    var productId = ""
    var productData : NSDictionary!
    let sizeArray = ["M","L","XL","XXL"]
    let color = ["Blue","Black","Green","Grey"]
///
    var similarProductData = [AnyObject]()
    var storeId = ""
    var userId = ""
    var key = ""
    var categoryId = ""
    var gallery = [AnyObject]()
///
    var masterTotal = Double()
    var total = Double()
    var discoun = Double()
///
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if key == "My"{
            editProduct.isHidden = false
            addFavourite.isHidden = true
        }else if key == "cart"{
            addFavourite.isHidden = false
            editProduct.isHidden = true
            addFavourite.setTitle("Buy now", for: .normal)
        }else{
            addFavourite.isHidden = false
            editProduct.isHidden = true
            addFavourite.setTitle("Add to cart", for: .normal)
        }
        self.similarProduct.delegate = self
        self.similarProduct.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        userId = UserDefaults.standard.value(forKey: "id") as? String ?? ""
        getProductDetail()
    }
    
    func getData(){
        if let storeDetail = productData.object(forKey: "store") as? NSDictionary {
            self.storeId = storeDetail.object(forKey: "_id") as! String
        }
        print(storeId,"asdss")
        masterTotal = productData.object(forKey: "masterPrice") as! Double
        categoryId = productData.object(forKey: "categoryId") as! String
        print("aseded",categoryId)
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
        vc.productData = self.productData
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addReviewTapped(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddReviewVC") as! AddReviewVC
        vc.productId = self.productId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func mallLogoTapped(_ sender: Any) {
        NavigateToHome.sharedd.navigate(naviagtionC: self.navigationController!)
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
            if key == "cart"{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddressVC") as! AddressVC
                vc.key = "cart"
                UserDefaults.standard.setValue(self.productData.object(forKey:"deliveryCharges") as? Double ?? 0.0, forKey: "DeliveryCharges")
                let store = self.productData.object(forKey: "store") as? NSDictionary
                let tax = store?.object(forKey: "tax") as? Double ?? 10.0
                UserDefaults.standard.setValue(tax, forKey: "taxx")
                UserDefaults.standard.setValue(total, forKey: "price")
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else{
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
}

extension ProductDetailsVC{
    func getProductDetail(){
        ApiManager.shared.getProductById(productId: productId) { [self] isSuccess in
            if isSuccess{
                productData = ApiManager.shared.dataDict
                print(productData)
                setData()
                getSimilarProduct()
            }else{
                print("wrong url")
            }
        }
    }
    func setData(){
        productName.text = productData.object(forKey: "name") as! String
        detailLabel.text = productData.object(forKey: "description") as! String
        masterTotal = productData.object(forKey: "masterPrice") as! Double
        price.text = "$ \(masterTotal)"
        discoun = Double("\(productData.object(forKey: "discount") as! String)") ?? 0.0
        discount.text = "\(discoun) %"
        
        total = masterTotal - masterTotal*discoun/100
        print("tot",total)
       
        priceLast.text = "$ \(total)"
        let rating = productData.object(forKey: "rating") as! [AnyObject]
        if rating.count != 0{
            print(rating)
            //var ratingArray = [Double]()
//            for i in 0...rating.count-1{
//                ratingArray.append(rating[0]["rating"] as! Double)
//            }
            //print(ratingArray,"array")
            let averageRatingArray = rating.map{$0.value(forKey: "rating")} as? [Double]
            let totalOfRatingArray = averageRatingArray?.reduce(0,+)
            let totalcount = Double(averageRatingArray!.count)
            print(totalcount,"abcbb")
            let sdd = totalOfRatingArray!/totalcount
            print(sdd,"gfgf")
            self.reviewStars.rating = Double(totalOfRatingArray!/totalcount)
            print(self.reviewStars.rating,"abcdd")
            reviewCount.text = "\(rating.count) review"
            ratingStars.rating = rating[0]["rating"] as! Double
            ratingStars.isUserInteractionEnabled = false
//            ratingView.rating = rating[0]["rating"] as! Double
            self.review.text = rating[0]["review"] as? String
            let date = rating[0]["postedOn"] as! String
            print(date)
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
             let datt = dateFormat.date(from: date)
            dateFormat.dateStyle = .medium
            self.reviewdate.text = dateFormat.string(from: datt ?? Date())
            self.reviewerName.text = rating[0]["customerName"] as? String ?? "Anonymous"
        }
        getData()

        picCollection.reloadData()
        colorCollection.reloadData()
        similarProduct.reloadData()
        
    }
}
extension ProductDetailsVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sizeCollection{
            return sizeArray.count
        }else if collectionView == similarProduct{
            return similarProductData.count
        }else{
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
            cell.productName.text = similarProductData[indexPath.item]["name"] as! String
            cell.price.text = "$ \(similarProductData[indexPath.item]["masterPrice"] as! NSNumber)"
            if let gallery = similarProductData[indexPath.item]["gallery"] as? [AnyObject]{
                if let image = gallery[0]["name"] as? String{
                    let url = URL(string: "http://93.188.167.68/projects/mymall_nodejs/assets/images/\(image)")
                    if url != nil{
                        cell.similarPic.af.setImage(withURL: url!)
                    }
                    else{
                        print("vd")
                    }
                }
            }
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == similarProduct{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            print("hello")
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
    
    @IBOutlet weak var similarPic: UIImageView!
    @IBOutlet weak var similarView: UIView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
    
    }
}


extension ProductDetailsVC{
    func getSimilarProduct(){
        ApiManager.shared.getSimilarProucts(categoryid: self.categoryId) { isSuccess in
            if isSuccess{
                self.similarProductData = ApiManager.shared.data
                self.similarProduct.reloadData()
            }else{
                print("bvcmcchg tyfy chd",ApiManager.shared.msg)
            }
        }
    }
}
