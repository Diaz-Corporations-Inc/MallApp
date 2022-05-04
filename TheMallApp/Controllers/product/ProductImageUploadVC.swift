//
//  ProductImageUploadVC.swift
//  TheMallApp
//
//  Created by M1 on 11/04/22.
//

import UIKit

class ProductImageUploadVC: BaseClass {

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!

    var imageArray = [UIImage]()
    var productId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    ///
    @IBAction func backTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    ///
    @IBAction func selectImage1(_ sender: UIButton){
        openCameraAndPhotos(isEditImage: true) { [self] image, string in
            self.image1.image = image
            self.imageArray.append(image)
            print("sdfsad",imageArray)
        } failure: {Error in
            print(Error)
        }
    }
    ///
    @IBAction func selectImage2(_ sender: UIButton){
        openCameraAndPhotos(isEditImage: true) { [self] image, string in
            self.image2.image = image
            self.imageArray.append(image)
            print("sdfsad",imageArray)
        } failure: {Error in
            print(Error)
        }
    }
    ///
    @IBAction func selectImage3(_ sender: UIButton){
        openCameraAndPhotos(isEditImage: true) { [self] image, string in
            self.image3.image = image
            self.imageArray.append(image)
            print("sdfsad",imageArray)
        } failure: {Error in
            print(Error)
        }
    }
    ///
    @IBAction func selectImage4(_ sender: UIButton){
        openCameraAndPhotos(isEditImage: true) { [self] image, string in
            self.image4.image = image
            self.imageArray.append(image)
            print("sdfsad",imageArray)
        } failure: {Error in
            print(Error)
        }
    }
    ///
    @IBAction func submitTapped(_ sender: UIButton){
        ImageUpload()
    }

}

extension ProductImageUploadVC{
    func ImageUpload(){
        ApiManager.shared.uploadProductImages(image: imageArray, type: "gallery", productId: self.productId,  progressCompletion: { [weak self] percent in
            guard let _ = self else {
              return
            }
            print("Status: \(percent)")
           if percent == 1.0{
               self?.showAlertWithOneAction(alertTitle: "", message: "Product images uploaded successfully", action1Title: "Ok") {[self] ok in
                   let vc = self?.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                   let navigationController = UINavigationController.init(rootViewController: vc)
                   let leftMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenu
                   let rightMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenu") as! SideMenu
                   self?.navigationController?.pushViewController(navigationController, animated: true)
               }            }
          },

          completion: { [weak self] result in
            guard let _ = self else {
              return
            }
        })
    }
}

