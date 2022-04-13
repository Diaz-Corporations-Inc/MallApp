//
//  AddStoreImage.swift
//  TheMallApp
//
//  Created by M1 on 09/04/22.
//

import UIKit
import Alamofire

class AddStoreImage: BaseClass {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    
    var imageArray = [UIImage]()
    var storeId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
print(storeId,"jghvhf")
    
    }
    
    @IBAction func skipTapped(_ sender: Any) {
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImage1(_ sender: Any) {
        openCameraAndPhotos(isEditImage: false) { [self] image, string in
            self.image1.image = image
            self.imageArray.append(image)
            print("sdfsad",imageArray)
        } failure: {Error in
            print(Error)
        }

        
    }
    @IBAction func addImage2(_ sender: Any) {
        openCameraAndPhotos(isEditImage: false) { [self] image, string in
            self.image2.image = image
            self.imageArray.append(image)
            print("sdfsad",imageArray)
        } failure: {Error in
            print(Error)
        }
        
    }
    @IBAction func addImage3(_ sender: Any) {
        openCameraAndPhotos(isEditImage: false) { [self] image, string in
            self.image3.image = image
            self.imageArray.append(image)
            print("sdfsad",imageArray)
        } failure: {Error in
            print(Error)
        }
        
    }
    @IBAction func addImage4(_ sender: Any) {
        openCameraAndPhotos(isEditImage: false) { [self] image, string in
            self.image4.image = image
            self.imageArray.append(image)
            print("sdfsad",imageArray)
        } failure: {Error in
            print(Error)
        }
        
    }
    @IBAction func submitTapped(_ sender: Any) {
        uploadStoreImages(
            image: self.imageArray,
            type: "gallery",
                    progressCompletion: { [weak self] percent in
                       guard let _ = self else {
                         return
                       }
                       print("Status: \(percent)")
                      if percent == 1.0{
                     self!.alert(message: "Store Images updated Successfully", title: "Image")
                       }
                     },
         
                     completion: { [weak self] result in
                       guard let _ = self else {
                         return
                       }
                   })
    }
    
}

extension AddStoreImage{
    func uploadStoreImages(image: [UIImage],type: String,
                      progressCompletion: @escaping (_ percent: Float) -> Void,
                      completion: @escaping (_ result: Bool) -> Void) {
//              guard let imageData = image.jpegData(compressionQuality: 0.5) else {
//              print("Could not get JPEG representation of UIImage")
//              return
//            }
       
            let randomno = Int.random(in: 1000...100000)
           let imgFileName = "image\(randomno).jpg"
        
            
        let userId = UserDefaults.standard.value(forKey: "id") as! String
            AF.upload(
              multipartFormData: { multipartFormData in
                
                for i in 0...image.count-1{
                                    
                    multipartFormData.append(image[i].jpegData(compressionQuality: 0.5)!,
                                             withName: "files[]",
                                             fileName: imgFileName,
                                             mimeType: "image/jpeg")
                               
                              }
                         
//
              },
              to:  Api.storeImage+self.storeId+"/\(type)", usingThreshold: UInt64.init(), method: .put)
              .uploadProgress { progress in
                   progressCompletion(Float(progress.fractionCompleted))
              }
              .response { response in
                  debugPrint(response)
              }
          }
}
