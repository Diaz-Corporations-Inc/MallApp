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
import LocationPicker
import MapKit
import DropDown

class StoreDetailsVC: UIViewController,CLLocationManagerDelegate, PlacesPickerDelegate,UITextViewDelegate, UITextFieldDelegate {
   
    
    func placePickerController(controller: PlacePickerController, didSelectPlace place: GMSPlace) {
        print(place)
    }
    
    func placePickerControllerDidCancel(controller: PlacePickerController) {
       dismiss(animated: true, completion: nil)
    }
    
  
    
    @IBOutlet weak var categorySelect: UITextField!
    
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
///
    @IBOutlet weak var shippingCharge: UITextField!
///
    @IBOutlet weak var storeName: UITextField!
    @IBOutlet var viewCollOutlet: [UIView]!
    @IBOutlet weak var doneBtn: UIButton!

    let datePick = UIDatePicker()
    var lat = 0.0
    var long = 0.0
    let manager = CLLocationManager()
    var key = ""
    var storeType = ""
    var storeData = NSDictionary()
    var drop = DropDown()
    var filterArray = [String]()
    var categoryId = [String]()
    var catIdtoSend = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeOpenTime.delegate = self
        storeColsingTime.delegate = self
        storeDescription.delegate = self
        
      
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        
        if key != ""{
            setData()
        }else{
            print("")
            storeDescription.text = "Store detail..."
            storeDescription.textColor = UIColor.lightGray
        }

        for i in 0...viewCollOutlet.count-1{
            viewCollOutlet[i].layer.cornerRadius = 10
            viewCollOutlet[i].layer.shadowOpacity = 1
            viewCollOutlet[i].layer.shadowRadius = 1
            viewCollOutlet[i].layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            viewCollOutlet[i].layer.shadowColor = UIColor.gray.cgColor
        }
        
       // doneBtn.layer.cornerRadius = 10
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        getCategory()
        
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
    
    @IBAction func backTapped(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func mallLogoTapped(_ sender: Any) {
        NavigateToHome.sharedd.navigate(naviagtionC: self.navigationController!)
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        let userId = UserDefaults.standard.value(forKey: "id") as! String
        let timing = timingModel(to: storeColsingTime.text!, from: storeOpenTime.text!)
        let storeType = UserDefaults.standard.value(forKey: "storetype") as? String ?? ""
        let location = locationM(coordinates: [lat,long])
        let price = priceRangeModel(to: higherPrice.text!, from: lowPrice.text!)
        let createStoreModel = createStoreModel(description: storeDescription.text!,userId: userId, name: storeName.text!, slogan: "", webSiteUrl: webUrl.text!, timing: timing, priceRange: price, location:location, city: city.text!, scotNo: scotNo.text!, state: state.text!, landmark: landmark.text!,contactNo: storeContact.text!, zipCode: zipcode.text!, categoryId: catIdtoSend,address: mapLocation.text!,storeType: storeType,deliveryCharges: Double(shippingCharge.text!) ?? 0.0)
        print("sadfasdf")
        print(createStoreModel)
        print("sdfsd")
        
        ARSLineProgress.show()
        if key == "" {
            if shippingCharge.text == ""{
                self.showAlertWithTwoActions(alertTitle: "My Mall", message: "You have't added shipping charges so app will calculate the charges based on location to continue press ok ", action1Title: "Cancel", action1Style: .destructive, action2Title: "OK") { cancel in
                    ARSLineProgress.hide()
                    print("Hello")
                } completion2: { ok in
                    ApiManager.shared.createStore(model: createStoreModel) { issuccess in
                        ARSLineProgress.hide()
                        if issuccess{
                            print("created",ApiManager.shared.msg)
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageUploadVC") as! ImageUploadVC
                            self.navigationController?.pushViewController(vc, animated: true)
                        }else{
                            self.alert(message: "Your store already exists")
                            print(ApiManager.shared.msg)
                        }
                    }

                }

            }else{
                ApiManager.shared.createStore(model: createStoreModel) { issuccess in
                    ARSLineProgress.hide()
                    if issuccess{
                        print("created",ApiManager.shared.msg)
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageUploadVC") as! ImageUploadVC
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else{
                        self.alert(message: "Your store already exists")
                        print(ApiManager.shared.msg)
                    }
                }
            }
        }else{
            ApiManager.shared.updateStore(model: createStoreModel,storeId: storeData.object(forKey: "_id") as! String) { issuccess in
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
        addLocation()
        
    }
    
    @IBAction func selectCatgory(_ sender: Any) {
        drop.dataSource = filterArray
        drop.anchorView = categorySelect
        drop.show()
        drop.selectionAction = { [unowned self] (index,item) in
            categorySelect.text = item
            catIdtoSend = categoryId[index]
            drop.hide()
        }
    }
//    @IBAction func backTapped(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == storeOpenTime{
            datePicker(textField: storeOpenTime)
        }else{
            datePicker(textField: storeColsingTime)
        }
        
    }

}

//MARK: - date picker
extension StoreDetailsVC{
    func datePicker(textField: UITextField){
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels

        textField.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(done))
        
        let flexiblebtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([cancelBtn,flexiblebtn,doneBtn], animated: false)
        textField.inputAccessoryView = toolbar
 }

    @objc func done(){
//        datePick.resignFirstResponder()
        self.storeOpenTime.resignFirstResponder()
        self.storeColsingTime.resignFirstResponder()
        
        if let datePicker = storeColsingTime.inputView as? UIDatePicker{
            datePicker.datePickerMode = .time
            let dateformatter  = DateFormatter()
            dateformatter.timeStyle = .short
            self.storeColsingTime.text = dateformatter.string(from: datePicker.date)
        }
         if let datePicker = storeOpenTime.inputView as? UIDatePicker{
            datePicker.datePickerMode = .time
            let dateformatter  = DateFormatter()
            dateformatter.timeStyle = .short
            self.storeOpenTime.text = dateformatter.string(from: datePicker.date)
        }
    }
    @objc func cancel(){
//        datePick.resignFirstResponder()
        self.storeOpenTime.resignFirstResponder()
        self.storeColsingTime.resignFirstResponder()
    }

}
///
extension StoreDetailsVC{
    func setData(){
        
        self.storeName.text = storeData.object(forKey: "name") as? String ?? ""
        self.storeContact.text = storeData.object(forKey: "contactNo") as? String ?? ""
        let storeTiming = storeData.object(forKey: "timing") as! NSDictionary
        self.storeOpenTime.text = storeTiming.object(forKey: "from") as? String ?? ""
        self.storeColsingTime.text = storeTiming.object(forKey: "to") as? String ?? ""
        let storePrices = storeData.object(forKey: "priceRange") as! NSDictionary
        self.lowPrice.text = "\(storePrices.object(forKey: "from") as? Double ?? 0)"
        self.higherPrice.text = "\(storePrices.object(forKey: "to") as? Double ?? 0)"
        self.webUrl.text = storeData.object(forKey: "webSiteUrl") as? String ?? ""
        self.scotNo.text = storeData.object(forKey: "scotNo") as? String ?? ""
        self.city.text = storeData.object(forKey: "city") as? String ?? ""
        self.state.text = storeData.object(forKey: "state") as? String ?? ""
        self.zipcode.text = storeData.object(forKey: "zipCode") as? String ?? ""
        self.landmark.text = storeData.object(forKey: "landmark") as? String ?? ""
        self.storeDescription.text = storeData.object(forKey: "description") as? String ?? ""
        self.mapLocation.text = storeData.object(forKey: "address") as? String ?? ""
        let location = storeData.object(forKey: "location") as? NSDictionary ?? nil
        let coordinate = location?.object(forKey: "coordinates") as! [Double]
        self.storeType = storeData.object(forKey: "storeType") as? String ?? ""
        UserDefaults.standard.set(self.storeType, forKey: "storetype")
        self.lat = coordinate[0]
        self.long = coordinate[1]
        self.shippingCharge.text = "\(storeData.object(forKey: "deliveryCharges") as? Double ?? 0.0)"
        print(storeData.object(forKey: "description") as? String ?? "")
    }
}

extension StoreDetailsVC{
    
    func addLocation(){
        let locationPicker = LocationPickerViewController()
        
        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 37.331686, longitude: -122.030656), addressDictionary: nil)
        let location = Location(name: "1 Infinite Loop, Cupertino", location: nil, placemark: placemark)
        locationPicker.location = location

        locationPicker.showCurrentLocationButton = true // default: true
        locationPicker.currentLocationButtonBackground = .blue
        locationPicker.showCurrentLocationInitially = true // default: true
        locationPicker.mapType = .satellite // default: .Hybrid
        locationPicker.useCurrentLocationAsHint = true // default: false
        locationPicker.searchBarPlaceholder = "Search places" // default: "Search or enter an address"
        locationPicker.searchHistoryLabel = "Previously searched" // default: "Search History"
        locationPicker.resultRegionDistance = 500 // default: 600
        locationPicker.completion = { [self] location in
            self.mapLocation.text =  location!.address
            lat = (location?.coordinate.latitude)!
//            print("sn",lat)
            long = (location?.coordinate.longitude)!
//            print("long",long)
        }
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(locationPicker, animated: true)
    }
}


extension StoreDetailsVC{
    func getCategory(){
        ApiManager.shared.getCategories { isSuccess in
            ApiManager.shared.getCategories { [self] isSuccess in
                if isSuccess{
                    let data = ApiManager.shared.data
                    for i in 0...data.count-1{
                        filterArray.append(data[i]["name"] as! String)
                        categoryId.append(data[i]["_id"] as! String)
                    }
                }else{
                    alert(message: ApiManager.shared.msg)
                }
            }
    }
}
}
