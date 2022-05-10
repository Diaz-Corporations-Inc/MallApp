//
//  File.swift
//  TheMallApp
//
//  Created by mac on 08/02/2022.
//

import UIKit

class BrowseCell: UITableViewCell{
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var available: UILabel!
    @IBOutlet weak var apartmentname: UILabel!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var DetailBtn: UIButton!
    
    override  func awakeFromNib() {
        viewCell.layer.cornerRadius = 20
//      viewCell.layer.borderWidth = 1
//      viewCell.layer.borderColor = UIColor.gray.cgColor
        viewCell.layer.shadowColor = UIColor.gray.cgColor
        viewCell.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        viewCell.layer.shadowRadius = 5
        viewCell.layer.shadowOpacity = 0.9
    }
    
}


