//
//  File.swift
//  TheMallApp
//
//  Created by mac on 09/02/2022.
//

import UIKit


class OldDealCollCell: UICollectionViewCell{
    
    @IBOutlet weak var productname: UILabel!
    @IBOutlet weak var oldDealView: UIView!
    @IBOutlet weak var imageOld: UIImageView!
    
    override  func awakeFromNib() {
        oldDealView.layer.cornerRadius = 20
        imageOld.layer.cornerRadius = 20
//        viewCell.layer.borderWidth = 1
//        viewCell.layer.borderColor = UIColor.gray.cgColor
        oldDealView.layer.shadowColor = UIColor.gray.cgColor
        oldDealView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        oldDealView.layer.shadowRadius = 5
        oldDealView.layer.shadowOpacity = 0.9
    }
}
