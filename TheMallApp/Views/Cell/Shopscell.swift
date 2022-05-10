//
//  neww.swift
//  TheMallApp
//
//  Created by Macbook on 07/02/22.
//

import UIKit


class Shopscell: UICollectionViewCell{
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var shopOffer: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellImage: UIImageView!
    
    override func prepareForReuse() {
        if cellImage.image != nil{
            self.cellImage.image = nil
        }
        super.prepareForReuse()
    }
}
