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

class StoreDetailsVC: UIViewController,CLLocationManagerDelegate, PlacesPickerDelegate {
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
   
    override func viewDidLoad() {
        super.viewDidLoad()
//        storeOpenTime.delegate = self
//        storeColsingTime.delegate = self
//        doneBtn.addTarget(self, action: #selector(didTapCheckoutButton), for: .touchUpInside)

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
    
    @IBAction func doneTapped(_ sender: Any) {
//        let userId = UserDefaults.standard.value(forKey: "id") as! String
//        let timing = timingModel(to: storeColsingTime.text!, from: storeOpenTime.text!)
//
//        let location = locationM(coordinates: [12.0000,12.00000])
//        let price = priceRangeModel(to: higherPrice.text!, from: lowPrice.text!)
//        let createStoreModel = createStoreModel(description: storeDescription.text!,userId: userId, name: storeName.text!, slogan: storeContact.text!, webSiteUrl: webUrl.text!, timing: timing, priceRange: price, location:location, city: city.text!, scotNo: scotNo.text!, state: state.text!, landmark: landmark.text!, zipCode: zipcode.text!)
//
//        print(createStoreModel)
//        print("dnfivbifd")
//        ARSLineProgress.show()
//        ApiManager.shared.createStore(model: createStoreModel) { issuccess in
//            ARSLineProgress.hide()
//            if issuccess{
//                print("created",ApiManager.shared.msg)
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageUploadVC") as! ImageUploadVC
//                self.navigationController?.pushViewController(vc, animated: true)
//            }else{
//                print(ApiManager.shared.msg)
//            }
//        }
        
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
