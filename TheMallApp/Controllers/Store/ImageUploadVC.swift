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
    var key = ""
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
        ApiManager.shared.uploadStoreImage(image: self.logoImage.image!, type: "logo",
                    progressCompletion: { [weak self] percent in
                       guard let _ = self else {
                         return
                       }
                       print("Status: \(percent)")
                      if percent == 1.0{
                          let vc = self?.storyboard?.instantiateViewController(withIdentifier: "StoreVC") as! StoreVC
                          vc.key = "I"
                          self?.navigationController?.pushViewController(vc, animated: true)
                       }
                     },
                     completion: { [weak self] result in
                       guard let _ = self else {
                         return
                       }
                   })
        
       
    }
    
    @IBAction func logo(_ sender: Any) {
        openCameraAndPhotos(isEditImage: false) { [self] image, string in
            self.logoImage.image = image
        } failure: {Error in
            print(Error)
        }

        
    }
    
   
}
