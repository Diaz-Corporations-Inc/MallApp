//
//  Files.swift
//  TheMallApp
//
//  Created by mac on 09/02/2022.
//

import UIKit

class DealsCollCell: UICollectionViewCell{
    @IBOutlet weak var collView: UIView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override  func awakeFromNib() {
        
        collView.layer.cornerRadius = 20
        productImage.layer.cornerRadius = 20
        collView.layer.shadowColor = UIColor.gray.cgColor
        collView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        collView.layer.shadowRadius = 5
        collView.layer.shadowOpacity = 10
    }
}
