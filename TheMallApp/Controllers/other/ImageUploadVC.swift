//
//  ImageUploadVC.swift
//  TheMallApp
//
//  Created by Macbook on 01/03/22.
//

import UIKit

class ImageUploadVC: BaseClass {

    @IBOutlet weak var backTapped: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var imgg1: UIImageView!
    @IBOutlet weak var imgg2: UIImageView!
    @IBOutlet weak var imgg3: UIImageView!
    @IBOutlet weak var imgg4: UIImageView!
    let key = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backTaped(_ sender: Any) {
        if key == ""{
            self.navigationController?.popViewController(animated: true)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func continueTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StoreVC") as! StoreVC
        vc.key = "I"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func logo(_ sender: Any) {
        openCameraAndPhotos(isEditImage: false) { [self] image, string in
            self.logoImage.image = image
        } failure: {Error in
            print(Error)
        }

        
    }
    @IBAction func img1(_ sender: Any) {
        openCameraAndPhotos(isEditImage: false) { [self] image, string in
            self.imgg1.image = image
        } failure: {Error in
            print(Error)
        }
    }
    @IBAction func img4(_ sender: Any) {
        openCameraAndPhotos(isEditImage: false) { [self] image, string in
            self.imgg4.image = image
        } failure: {Error in
            print(Error)
        }
    }
    
    @IBAction func img3(_ sender: Any) {
        openCameraAndPhotos(isEditImage: false) { [self] image, string in
            self.imgg3.image = image
        } failure: {Error in
            print(Error)
        }
    }
    @IBAction func img2(_ sender: Any) {
        openCameraAndPhotos(isEditImage: false) { [self] image, string in
            self.imgg2.image = image
        } failure: {Error in
            print(Error)
        }
    }
}
