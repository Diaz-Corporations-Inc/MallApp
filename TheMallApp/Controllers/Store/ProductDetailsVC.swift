//
//  ProductDetailsVC.swift
//  TheMallApp
//
//  Created by mac on 11/02/2022.
//

import UIKit

class ProductDetailsVC: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.similarProduct.delegate = self
        self.similarProduct.dataSource = self
        
    }
    
    @IBAction func viewAllTapped(_ sender: Any) {
    }
    @IBAction func likeTapped(_ sender: Any) {
    }
    
    @IBAction func addToFavourite(_ sender: Any) {
    }
    

}


extension ProductDetailsVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == picCollection{
            let cell = picCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCollcell
            
            return cell
        }else if collectionView == colorCollection{
            let cell = colorCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductColor
            cell.colorView.layer.borderWidth = 1
            cell.colorView.layer.borderColor = UIColor.gray.cgColor
            return cell
        }else if collectionView == sizeCollection{
            let cell = sizeCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductSize
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
