//
//  MapTableCell.swift
//  TheMallApp
//
//  Created by Macbook on 07/02/22.
//

import UIKit

class MapTableCell: UITableViewCell {

    @IBOutlet weak var shopImage: UIImageView!
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var mapTabView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mapTabView.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
