//
//  StoreDetailsVC.swift
//  TheMallApp
//
//  Created by mac on 15/02/2022.
//

import UIKit
import ARSLineProgress
import GoogleMaps
import PlacesPicker
import GooglePlaces
import CoreLocation

class StoreDetailsVC: UIViewController,CLLocationManagerDelegate, PlacesPickerDelegate,UITextViewDelegate, UITextFieldDelegate {
   
    
    func placePickerController(controller: PlacePickerController, didSelectPlace place: GMSPlace) {
        print(place)
    }
    
    func placePickerControllerDidCancel(controller: PlacePickerController) {
       dismiss(animated: true, completion: nil)
    }
    
  
    

    @IBOutlet weak var mapLocation: UITextField!
    @IBOutlet weak var scotNo: UITextField!
    @IBOutlet weak var storeDescription: UITextView!
    @IBOutlet weak var landmark: UITextField!
    @IBOutlet weak var zipcode: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var webUrl: UITextField!
    @IBOutlet weak var higherPrice: UITextField!
    @IBOutlet weak var lowPrice: UITextField!
    @IBOutlet weak var storeColsingTime: UITextField!
    @IBOutlet weak var storeOpenTime: UITextField!
    @IBOutlet weak var storeContact: UITextField!

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var storeName: UITextField!
    @IBOutlet var viewCollOutlet: [UIView]!
    @IBOutlet weak var doneBtn: UIButton!
    
    let datePick = UIDatePicker()

    let manager = CLLocationManager()
   var key = ""
    var storeData = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        storeOpenTime.delegate = self
        storeColsingTime.delegate = self
        
        storeDescription.delegate = self
        storeDescription.text = "Store detail..."
        storeDescription.textColor = UIColor.lightGray
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        
        for i in 0...viewCollOutlet.count-1{
            viewCollOutlet[i].layer.cornerRadius = 10
            viewCollOutlet[i].layer.shadowOpacity = 1
            viewCollOutlet[i].layer.shadowRadius = 1
            viewCollOutlet[i].layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            viewCollOutlet[i].layer.shadowColor = UIColor.gray.cgColor
        
        }
       // doneBtn.layer.cornerRadius = 10
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if storeDescription.text == "Store detail..."{
            storeDescription.text = ""
            storeDescription.textColor = UIColor.black
        }else{
            storeDescription.textColor = UIColor.black
        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if storeDescription.text.isEmpty {
            storeDescription.text = "Store detail..."
            storeDescription.textColor = UIColor.lightGray
        }else{
            storeDescription.textColor = UIColor.black
        }
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        let userId = UserDefaults.standard.value(forKey: "id") as! String
        let timing = timingModel(to: storeColsingTime.text!, from: storeOpenTime.text!)

        let location = locationM(coordinates: [12.0000,12.00000])
        let price = priceRangeModel(to: higherPrice.text!, from: lowPrice.text!)
        let createStoreModel = createStoreModel(description: storeDescription.text!,userId: userId, name: storeName.text!, slogan: "", webSiteUrl: webUrl.text!, timing: timing, priceRange: price, location:location, city: city.text!, scotNo: scotNo.text!, state: state.text!, landmark: landmark.text!,contactNo: storeContact.text!, zipCode: zipcode.text!)

        print(createStoreModel)
        ARSLineProgress.show()
        if key == "" {
            ApiManager.shared.createStore(model: createStoreModel) { issuccess in
                ARSLineProgress.hide()
                if issuccess{
                    print("created",ApiManager.shared.msg)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageUploadVC") as! ImageUploadVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.alert(message: ApiManager.shared.msg)
                    print(ApiManager.shared.msg)
                }
            }
        }else{
            ApiManager.shared.updateStore(model: createStoreModel,storeId: "") { issuccess in
                ARSLineProgress.hide()
                if issuccess{
                    print("created",ApiManager.shared.msg)
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageUploadVC") as! ImageUploadVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    self.alert(message: ApiManager.shared.msg)
                    print(ApiManager.shared.msg)
                }
            }
        }
       
      
        
//        didTapCheckoutButton()
    }
    @IBAction func searchLocation(_ sender: Any) {
        let controller = PlacePicker.placePickerController()
        controller.delegate = self
        let navigation = UINavigationController(rootViewController: controller)
        self.show(navigation, sender: nil)
        
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
//        didTapCheckoutButton()
    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        datePicker()
//    }

}

//MARK: - Store detail api

//extension StoreDetailsVC{
//
//}

//MARK: - date picker
//extension StoreDetailsVC: UITextFieldDelegate{
//    func datePicker(){
//        datePick.datePickerMode = .time
//        datePick.preferredDatePickerStyle = .wheels
//
//        let toolbar = UIToolbar();
//          toolbar.sizeToFit()
//
//        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(done))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancel))
//          toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
// }
//
//    @objc func done(){
//        let formatter = DateFormatter()
//           formatter.dateFormat = "HH:mm"
//        self.storeOpenTime.text = formatter.string(from: datePick.date)
//           //dismiss date picker dialog
//        datePick.resignFirstResponder()
//    }
//    @objc func cancel(){
//        datePick.resignFirstResponder()
//
//    }
//
//}

extension StoreDetailsVC{
    func setData(){
        self.storeName.text = storeData.object(forKey: "name") as! String
        self.storeContact.text = storeData.object(forKey: "contactNo") as! String
        let storeTiming = storeData.object(forKey: "timing") as! NSDictionary
        self.storeOpenTime.text = storeTiming.object(forKey: "from") as! String
        self.storeColsingTime.text = storeTiming.object(forKey: "to") as! String
        let storePrices = storeData.object(forKey: "priceRange") as! NSDictionary
        self.lowPrice.text = storeTiming.object(forKey: "from") as! String
        self.higherPrice.text = storeTiming.object(forKey: "to") as! String
        self.webUrl.text = storeData.object(forKey: "webSiteUrl") as! String
        self.scotNo.text = storeData.object(forKey: "scotNo") as! String
        self.city.text = storeData.object(forKey: "city") as! String
        self.state.text = storeData.object(forKey: "state") as! String
        self.zipcode.text = storeData.object(forKey: "zipCode") as! String
        self.landmark.text = storeData.object(forKey: "landmark") as! String
        self.storeDescription.text = storeData.object(forKey: "description") as! String
    }
}

//{
//
//     myData = ApiManager.shared.data
//    if myData.count != 0{
//        storeName.text = myData[0]["name"] as! String
//        storeDescription.text = myData[0]["description"] as! String
//        let timingDict = myData[0]["timing"] as! NSDictionary
//        storeTiming.text = "\(timingDict.object(forKey: "from") as? String ?? "") - \(timingDict.object(forKey: "to") as? String ?? "") "
//     let priceRangedict = myData[0]["priceRange"] as! NSDictionary
//        priceRange.text = "\(priceRangedict.object(forKey: "from") as? Int ?? 0) - \(priceRangedict.object(forKey: "to") as? Int ?? 0) $"
//        contact.text = myData[0]["contactNo"] as! String
//        storeLocation.text = "\(myData[0]["city"] as! String),\(myData[0]["state"] as! String),\(myData[0]["zipCode"] as! String),Near \(myData[0]["landmark"] as! String)"
//        gallery = myData[0]["gallery"] as! [AnyObject]
////                    if let logo =
//        if let logoImage = myData[0]["logo"] as? String{
//            DispatchQueue.main.async {
//                let url = URL(string: "http://93.188.167.68/projects/mymall_nodejs/assets/images/\(logoImage)")
//                if url != nil{
//                    self.companyImge.af.setImage(withURL: url!)
//                }else{
//                    self.companyImge.image = UIImage(named: "")
//                }
//            }
//        }
//
//        storeCollection.reloadData()
//    }
//
//}
