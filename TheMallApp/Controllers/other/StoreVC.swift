//
//  StoreVC.swift
//  TheMallApp
//
//  Created by mac on 14/02/2022.
//

import UIKit

class StoreVC: UIViewController {

    @IBOutlet weak var storeCollection: UICollectionView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var companyImge: UIImageView!
    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var storeTiming: UILabel!
    @IBOutlet weak var storeLocation: UILabel!
    @IBOutlet weak var contact: NSLayoutConstraint!
    @IBOutlet weak var priceRange: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func backTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func visitWebsite(_ sender: Any) {
    }
    
}

extension StoreVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = storeCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! StoreCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: storeCollection.frame.width/3, height: storeCollection.frame.height/3)
    }
    
    
    
}

class StoreCell: UICollectionViewCell{
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellImage: UIImageView!
}
