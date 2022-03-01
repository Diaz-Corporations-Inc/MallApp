//
//  Filel.swift
//  TheMallApp
//
//  Created by mac on 09/02/2022.
//

import UIKit

class PromoCollCell: UICollectionViewCell{
    @IBOutlet weak var promoImage: UIImageView!
    @IBOutlet weak var promoView: UIView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var offer: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override  func awakeFromNib() {
        promoView.layer.cornerRadius = 20
//        promoView.layer.backgroundColor = UIColor.red.cgColor
        promoView.layer.shadowColor = UIColor.gray.cgColor
        promoView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        promoView.layer.shadowRadius = 5
        promoView.layer.shadowOpacity = 0.9
    }
}
