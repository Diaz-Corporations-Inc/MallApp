//
//  DealsOfDayVC.swift
//  TheMallApp
//
//  Created by mac on 09/02/2022.
//

import UIKit

class DealsOfDayVC: UIViewController {

    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var dealsCollection: UICollectionView!
    @IBOutlet weak var promoCollection: UICollectionView!
    @IBOutlet weak var oldDealsCollection: UICollectionView!
    var key = ""
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    
    @IBAction func contactUsTapped(_ sender: Any) {
    }
    @IBAction func registerTapped(_ sender: Any) {
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func mikeTapped(_ sender: Any) {
    }
    
    

}

extension DealsOfDayVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == dealsCollection{
            let cell = dealsCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DealsCollCell
            cell.collView.layer.shadowColor = UIColor.gray.cgColor
            cell.collView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cell.collView.layer.shadowRadius = 1
            cell.collView.layer.shadowOpacity = 5
            return cell
        }else if collectionView == promoCollection{
            let cell = promoCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PromoCollCell
            cell.promoView.layer.borderWidth = 1
            cell.promoView.layer.borderColor = UIColor.gray.cgColor
//            cell.promoView.layer.shadowColor = UIColor.gray.cgColor
//            cell.promoView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
//            cell.promoView.layer.shadowRadius = 1
//            cell.promoView.layer.shadowOpacity = 5
            return cell
        }else{
            let cell = oldDealsCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OldDealCollCell
            cell.oldDealView.layer.borderColor = UIColor.gray.cgColor
            cell.oldDealView.layer.borderWidth = 1
            cell.oldDealView.layer.shadowColor = UIColor.gray.cgColor
            cell.oldDealView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cell.oldDealView.layer.shadowRadius = 1
            cell.oldDealView.layer.shadowOpacity = 5
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
    
}
