//
//  AddProductVC.swift
//  TheMallApp
//
//  Created by M1 on 21/03/22.
//

import UIKit

class AddProductVC: UIViewController,UIColorPickerViewControllerDelegate {
    
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var productPrice: UITextField!
    @IBOutlet weak var productType: UITextField!
    @IBOutlet weak var colorCollection: UICollectionView!
    @IBOutlet weak var sizeCollection: UICollectionView!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var productImageColl: UICollectionView!
    @IBOutlet var viewsCollection: [UIView]!
    
    var colorPick = UIColorPickerViewController()
    let sizeArray = ["S","M","L","XL","XXL"]
    let colorArray = ["s"]
    let imageArray = ["q"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorPick.delegate = self
        for i in 0...viewsCollection.count-1{
            viewsCollection[i].layer.cornerRadius = 10
        }
    }
    
  

    
    @IBAction func backTaped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func continueTapped(_ sender: Any) {
    }
    @IBAction func colorBtn(_ sender: Any) {
        self.present(colorPick, animated: true, completion: nil)
    }
}


//func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
//
//    view?.backgroundColor = viewController.selectedColor
//}


class ColorCollCell: UICollectionViewCell{
    @IBOutlet weak var colorCellView: UIView!
    @IBOutlet weak var colorButton: UIButton!
    
}
class SizeCollCell: UICollectionViewCell{
    @IBOutlet weak var sizeView: UIView!
    @IBOutlet weak var sizeLabel: UILabel!
    
}
class ImageCollCell: UICollectionViewCell{
    
    @IBOutlet weak var productImage: UIImageView!
}

extension AddProductVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colorCollection{
            return colorArray.count
        }else if collectionView == sizeCollection{
            return sizeArray.count
        }else{
            return imageArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colorCollection{
            let cell = colorCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ColorCollCell
            return cell
        }else if collectionView == sizeCollection{
            let cell = sizeCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SizeCollCell
            cell.sizeLabel.text = sizeArray[indexPath.row]
            cell.sizeView.layer.borderColor = UIColor.gray.cgColor
            cell.sizeView.layer.borderWidth = 1
            return cell
        }else{
            let cell = productImageColl.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollCell
           
            return cell
        }
    }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            if collectionView == colorCollection{
                return CGSize(width: 60, height: colorCollection.frame.height)
            }else if collectionView == sizeCollection{
                return CGSize(width: 65, height: sizeCollection.frame.height)
            }else{
                return CGSize(width: 100, height: productImageColl.frame.height)
            }
        }
        
        
    }
