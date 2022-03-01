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
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func contactUsTapped(_ sender: Any) {
    }
    @IBAction func registerTapped(_ sender: Any) {
    }
    
    @IBAction func backButton(_ sender: Any) {
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
            return cell
        }else if collectionView == promoCollection{
            let cell = promoCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PromoCollCell
            return cell
        }else{
            let cell = oldDealsCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OldDealCollCell
            return cell
        }
    }
    
    
}
