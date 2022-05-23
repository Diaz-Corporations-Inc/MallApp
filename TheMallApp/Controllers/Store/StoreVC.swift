//
//  StoreVC.swift
//  TheMallApp
//
//  Created by mac on 14/02/2022.
//

import UIKit
import AVKit
import AKSideMenu
import ARSLineProgress
import CoreLocation
import MapKit

import AlamofireImage
class StoreVC: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

///
    //MARK: - outlets
    @IBOutlet weak var productbtn: UIView!
    @IBOutlet weak var addStoreImageBtn: UIView!
    @IBOutlet weak var mapStoreView: MKMapView!
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var scrollableView: UIView!
    @IBOutlet weak var storeDescription: UILabel!
    @IBOutlet weak var visitStore: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var storeCollection: UICollectionView!
    @IBOutlet weak var productCollection: UICollectionView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var companyImge: UIImageView!
    @IBOutlet weak var storeTiming: UILabel!
    @IBOutlet weak var storeLocation: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var priceRange: UILabel!
///
    //MARK: - VARIABLES AND PROPERTIES
    var gallery = [AnyObject]()
    var productData = [AnyObject]()
    var myData = [AnyObject]()
    var storeData : NSDictionary!
    var key = ""
    var storeId = ""
    var storeType = ""
    
 ///
    var locationManager = CLLocationManager()
    var getLocation = NSDictionary()
    var apiCoordinates = [AnyObject]()
    var locationName = ""
    var lat = Double()
    var long = Double()
 ///
    //MARK: - VIEW DID LOAD
 override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        mapStoreView.delegate = self
        mapStoreView.mapType = .standard
        mapStoreView.isZoomEnabled = true
        mapStoreView.isScrollEnabled = true
        if let coordinate = mapStoreView.userLocation.location?.coordinate{
            print(coordinate,"hello")
            mapStoreView.setCenter(coordinate, animated: true)
        }
        
        }
///
    //MARK: - VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        if key == "My"{
            editBtn.isHidden = false
            addStoreImageBtn.isHidden = false
            productbtn.isHidden = false
        }else{
            editBtn.isHidden = true
            productbtn.isHidden = true
            addStoreImageBtn.isHidden = true
        }
        setData()
    }
    //MARK: - didFailWithError
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
     print(error)
     }
    //MARK: - didUpdateLocations
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let locValue:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: long)

        print("asdsds",lat,long)
        mapStoreView.mapType = MKMapType.standard

        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapStoreView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = locationName
        annotation.subtitle = "Store location"
        mapStoreView.addAnnotation(annotation)

        //centerMap(locValue)
    }
///
//MARK: - BUTTON ACTIONS
    @IBAction func editBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "StoreDetailsVC") as! StoreDetailsVC
        vc.key = "S"
        vc.storeData = self.myData[0] as! NSDictionary
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backTapped(_ sender: Any) {
        if key == ""{
            self.navigationController?.popViewController(animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            let leftMenuViewController = storyboard?.instantiateViewController(withIdentifier: "SideMenu") as! SideMenu
            let rightMenuViewController = storyboard?.instantiateViewController(withIdentifier: "SideMenu") as! SideMenu
            let sideMenuViewController: AKSideMenu = AKSideMenu(contentViewController: vc, leftMenuViewController: leftMenuViewController, rightMenuViewController: rightMenuViewController)
            self.navigationController?.pushViewController(sideMenuViewController, animated: true)
        }
    }
    @IBAction func malllogoTapped(_ sender: Any) {
        NavigateToHome.sharedd.navigate(naviagtionC: self.navigationController!)
    }
    
    @IBAction func addStoreImagesTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddStoreImage") as! AddStoreImage
        vc.storeId = self.myData[0]["_id"] as! String
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func producttapped(_ sender: Any) {
        if storeType == "store"{
            self.showAlertWithTwoActions(alertTitle: "Alert", message: "You have registered for store listing only please continue to upgrade", action1Title: "Cancel", action1Style: .destructive, action2Title: "Continue") { ok in
                print("Stay here")
            } completion2: { cancel in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListingTypeVC") as! ListingTypeVC
                vc.key = "Upgrade"
                self.navigationController?.pushViewController(vc, animated: true)
            }

            
           
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "AddProductVC") as! AddProductVC
            vc.key = "My"
            vc.storeId = self.myData[0]["_id"] as! String
            vc.catIdtoSend = self.myData[0]["category"] as! String
            self.navigationController?.pushViewController(vc, animated: true)
        }
      
    }
    @IBAction func registoreStore(_ sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "ListingTypeVC") as! ListingTypeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func visitWebsite(_ sender: Any) {
       
    }
    
}
///
///
extension StoreVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == storeCollection{
            if key == "My"{
                if myData.count == 0{
                    scrollableView.isHidden = true
                    editBtn.isHidden = true
                    return 0
                }else{
                    scrollableView.isHidden = false
                    editBtn.isHidden = false
                    return gallery.count
                }
            }else{
                return gallery.count
            }
        }else{
            return productData.count
        }
    }
 ///
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == storeCollection{
            let cell = storeCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! StoreCell
            if key == "My"{
                if myData.count != 0{
                    if let logoImage = self.gallery[indexPath.row]["name"] as? String{
                        DispatchQueue.main.async {
                            let url = URL(string: "http://93.188.167.68/projects/mymall_nodejs/assets/images/\(logoImage)")
                            if url != nil{
                                cell.cellImage.af.setImage(withURL: url!)
                            }else{
                                cell.cellImage.image = UIImage(named: "")

                            }
                        }
                    }
                }

            }else{
                if storeData != nil{
                    if let logoImage = self.gallery[indexPath.row]["name"] as? String{
                        DispatchQueue.main.async {
                            let url = URL(string: "http://93.188.167.68/projects/mymall_nodejs/assets/images/\(logoImage)")
                            if url != nil{
                                cell.cellImage.af.setImage(withURL: url!)
                            }else{
                                cell.cellImage.image = UIImage(named: "")
                            }
                        }
                    }
                }
            }
            return cell
        }else{
            let cell = productCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! productCell
            cell.productPrice.text = "$\(productData[indexPath.item]["masterPrice"] as! Double)"
            cell.productName.text = productData[indexPath.item]["name"] as! String
            cell.brandName.text = productData[indexPath.item]["brand"] as! String
            cell.offOnProduct.text = "\(Double(productData[indexPath.item]["discount"] as? String ?? "0.0") ?? 0.0) %"
            if let gallery = productData[indexPath.item]["gallery"] as? [AnyObject]{
                if gallery.count != 0{
                    if let image = gallery[0]["name"] as? String{
                        let url = URL(string: "http://93.188.167.68/projects/mymall_nodejs/assets/images/\(image)")
                        if url != nil{
                            cell.productImage.af.setImage(withURL: url!)
                        }else{
                            print("hello")
                        }
                    }

                }
            }
            return cell
        }
       
    }
///
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == storeCollection{
            return CGSize(width: storeCollection.frame.width/1.8, height: storeCollection.frame.height)
        }else{
            return CGSize(width: productCollection.frame.width/2, height: productCollection.frame.height)
        }
        
    }
///
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {[self]
        if collectionView == productCollection{
            if key == "My"{
                let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
                vc.productId = productData[indexPath.row]["_id"] as! String
                vc.key = "My"
                self.navigationController?.pushViewController(vc, animated: true)
            }else{
                let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDetailsVC") as! ProductDetailsVC
                vc.productId = productData[indexPath.row]["_id"] as! String
                self.navigationController?.pushViewController(vc, animated: true)
            }
         
        }else{
            print("hello")
        }
    }
    
}

class StoreCell: UICollectionViewCell{
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellImage: UIImageView!
}
class productCell: UICollectionViewCell{
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var offOnProduct: UILabel!
}

extension StoreVC{
    func setData(){
        ARSLineProgress.show()
        if key == "My"{
            let id = UserDefaults.standard.value(forKey: "id") as! String
            ApiManager.shared.myStore(id: id) { [self] isSuccess in
                ARSLineProgress.hide()
               
                if isSuccess{
    
                     myData = ApiManager.shared.data
                    print(self.myData.count,"abs")
                    if myData.count != 0{
                        ///
                        self.getLocation = myData[0]["location"] as! NSDictionary
                        self.apiCoordinates = getLocation.object(forKey: "coordinates") as! [AnyObject]
                        lat = self.apiCoordinates[0] as! Double
                        long = self.apiCoordinates[1] as! Double
                        print("asds",lat,long)
                        locationName = myData[0]["name"] as! String
                        ///
                        self.storeId = myData[0]["_id"] as! String
                        print("asdsa",self.storeId)
                        storeType = myData[0]["storeType"] as! String
                        storeName.text = myData[0]["name"] as! String
                        storeDescription.text = myData[0]["description"] as! String
                        let timingDict = myData[0]["timing"] as! NSDictionary
                        storeTiming.text = "\(timingDict.object(forKey: "from") as? String ?? "") - \(timingDict.object(forKey: "to") as? String ?? "") "
                     let priceRangedict = myData[0]["priceRange"] as! NSDictionary
                        priceRange.text = "\(priceRangedict.object(forKey: "from") as? Double ?? 0.0) - \(priceRangedict.object(forKey: "to") as? Double ?? 0.0) $"
                        contact.text = myData[0]["contactNo"] as! String
                        storeLocation.text = "\(myData[0]["city"] as! String),\(myData[0]["state"] as! String),\(myData[0]["zipCode"] as! String),Near \(myData[0]["landmark"] as! String)"
                        gallery = myData[0]["gallery"] as! [AnyObject]
    //                    if let logo =
                        if let logoImage = myData[0]["logo"] as? String{
                            DispatchQueue.main.async {
                                let url = URL(string: "http://93.188.167.68/projects/mymall_nodejs/assets/images/\(logoImage)")
                                if url != nil{
                                    self.companyImge.af.setImage(withURL: url!)
                                }else{
                                    self.companyImge.image = UIImage(named: "")
                                }
                            }
                        }
                        getProductData()
                        storeCollection.reloadData()
                    }
                 
                }else{
                    alert(message:ApiManager.shared.msg)
                }
            }
        }else{
            ApiManager.shared.storeById(storeid: storeId) { [self] stordata, isSuccess in
                ARSLineProgress.hide()
//                storeCollection.reloadData()
                if isSuccess{
                    storeData = stordata
                    ///
                    self.getLocation = storeData.object(forKey: "location") as! NSDictionary
                    self.apiCoordinates = getLocation.object(forKey: "coordinates") as! [AnyObject]
                    lat = self.apiCoordinates[0] as! Double
                    long = self.apiCoordinates[1] as! Double
                    print("asds",lat,long)
                    locationName = storeData.object(forKey: "name") as! String
                    ///
               
                    storeName.text = storeData.object(forKey: "name") as! String
                    storeDescription.text = storeData.object(forKey: "description") as! String

                    let timingDict = storeData.object(forKey: "timing") as! NSDictionary
                    storeTiming.text = "\(timingDict.object(forKey: "from") as? String ?? "") - \(timingDict.object(forKey: "to") as? String ?? "") "
                 let priceRangedict = storeData.object(forKey: "priceRange") as! NSDictionary
                    priceRange.text = "\(priceRangedict.object(forKey: "from") as? Double ?? 0) - \(priceRangedict.object(forKey: "to") as? Double ?? 0) $"
                    contact.text = storeData.object(forKey: "contactNo") as? String ?? "-"
                    storeLocation.text = "\(storeData.object(forKey: "city") as! String),\(storeData.object(forKey: "state") as! String),\(storeData.object(forKey: "zipCode") as! String),Near \(storeData.object(forKey: "landmark") as! String)"
                    gallery = storeData.object(forKey: "gallery") as! [AnyObject]
                    
                    if let logoImage = storeData.object(forKey: "logo") as? String{
                        DispatchQueue.main.async {
                            let url = URL(string: "http://93.188.167.68/projects/mymall_nodejs/assets/images/\(logoImage)")
                            if url != nil{
                                companyImge.af.setImage(withURL: url!)
                            }else{
                                companyImge.image = UIImage(named: "")
                            }
                        }
                    }
                    getProductData()
                    storeCollection.reloadData()
                }else{
                    ARSLineProgress.hide()
                    alert(message: ApiManager.shared.msg)
                }
            }

        }
        
    }
}


extension StoreVC{
    func getProductData(){
        
        ApiManager.shared.getStoreProducts(storeId: self.storeId) { isSuccess in
            if isSuccess{
                
                self.productData = ApiManager.shared.data
                print("sjdbfksbdajc",self.productData,"abcd")
                self.productCollection.reloadData()
            }else{
                print(self.storeId)
                print("please check store id")
            }
        }
    }
    
}
