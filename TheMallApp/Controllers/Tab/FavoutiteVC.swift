//
//  FavoutiteVC.swift
//  TheMallApp
//
//  Created by mac on 11/02/2022.
//

import UIKit
import AVKit
import Alamofire
import AlamofireImage
import ARSLineProgress

class FavoutiteVC: UIViewController {
    
    @IBOutlet weak var backbtn: UIButton!
    ///
    @IBOutlet weak var favouriteColl: UICollectionView!
    ///
    @IBOutlet weak var browseColl: UICollectionView!
    ///
    @IBOutlet weak var mallVideoView: UIView!
    ///
    @IBOutlet weak var favView: UIView!
    ////
    @IBOutlet weak var recentlyBrowsed: UICollectionView!
    ///
    @IBOutlet weak var recentViewHeight: NSLayoutConstraint!
    ///
    let player = AVPlayer()
///
    var looper : AVPlayerLooper!
 ///
    var selectedRows:[IndexPath] = []
    ///
    var storeData = [AnyObject]()
    ///
    var recentlyData = [AnyObject]()
    ///
    @IBOutlet weak var viewheight: NSLayoutConstraint!
    var data = [AnyObject]()
    ///
    var a = ""
    ///
    var storeId = ""
    ///
    var userId = ""
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = UserDefaults.standard.value(forKey: "id") as? String ?? ""
        playVideo()
        mallVideoView.backgroundColor = UIColor.clear
        if a == ""{
            backbtn.isHidden = true
        }else{
            backbtn.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setData()
        if userId == ""{
            print("login Please")
            setupUI()
        }else{
            getFav {[self] isSuccess in
                ARSLineProgress.hide()
                if isSuccess{
                    setupUI()
                    print("hello")
                    favouriteColl.reloadData()                   
                }else{
                    print("hii")
                }
            }
        }
      
    }
    
    func setupUI(){
        if data.count == 0{
            favouriteColl.isHidden = true
        }else{
            favouriteColl.isHidden = false
        }
    }
  
    func setData(){
        ///
        ARSLineProgress.show()
        ApiManager.shared.storeList { [self] isSuccess in
            ARSLineProgress.hide()
            if isSuccess{
                storeData = ApiManager.shared.data
                browseColl.reloadData()
            }
            else{
                print("sdbvjb")
            }
        }
        ///
        ARSLineProgress.show()
        ApiManager.shared.storeList { [self] isSuccess in
            ARSLineProgress.hide()
            if isSuccess{
                recentlyData = ApiManager.shared.data
                print("recently",recentlyData,"data")
                recentlyBrowsed.reloadData()
            }
            else{
                self.alert(message: ApiManager.shared.msg)
            }
        }
    }
    
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "abc", ofType:"mov") else {
            debugPrint("video.m4v not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        
        playerLayer.frame = self.mallVideoView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.mallVideoView.layer.addSublayer(playerLayer)
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { [weak self] _ in
            player.seek(to: CMTime.zero)
            player.play()
        }
        player.play()
        
    }
    @IBAction func nearYou(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LocationVC") as! LocationVC
        vc.key = "F"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func browseAll(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "BrowseAllVC") as! BrowseAllVC
        vc.a = "1"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func backTApped(_ sender: Any) {
        if a == "s"{
            self.dismiss(animated: true, completion: nil)
        }else{
            navigationController?.popViewController(animated: true)
            
        }
    }
    
    @IBAction func mallLogoTapped(_ sender: Any) {
        NavigateToHome.sharedd.navigate(naviagtionC: self.navigationController!)
    }
    
    
    @IBAction func likeTapped(_ sender: UIButton) {[self]
       
        let store = data[sender.tag]["store"] as! NSDictionary
            storeId = store.object(forKey: "_id") as! String
    
        let favModel = favouriteModel(userId: userId, storeId: storeId)
        ARSLineProgress.show()
        ApiManager.shared.favUnFav(model: favModel) {[self] isSuccess in
            if isSuccess{
                ARSLineProgress.hide()
                print("success")
                self.getFav { isSuccess  in
                    if isSuccess{
                        setupUI()
                        print("hello")
                        favouriteColl.reloadData()
                    }
                }
            }else{
                print("error")
            }
        }
//        let selectedIndexPath = IndexPath(item: sender.tag, section: 0)
//        if self.selectedRows.contains(selectedIndexPath)
//        {
//            self.selectedRows.remove(at: self.selectedRows.firstIndex(of: selectedIndexPath)!)
//        }
//        else
//        {
//            self.selectedRows.append(selectedIndexPath)
//        }
//        self.favouriteColl.reloadData()
    }
    
    
}

extension FavoutiteVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == favouriteColl{
            return data.count
        }else if collectionView == browseColl{
            return storeData.count
        }else{
            return recentlyData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {[self]
        if collectionView == favouriteColl{
            let cell = favouriteColl.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavouriteCell
            cell.likeBtn.tag = indexPath.row
            cell.cellView.layer.cornerRadius = 20
            cell.likeBtn.setImage(UIImage(named: "likeActive"), for: .normal)
            cell.cellView.layer.shadowColor = UIColor.gray.cgColor
            cell.cellView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            cell.cellView.layer.shadowRadius = 1
            cell.cellView.layer.shadowOpacity = 5
            if data.count != 0{
                print(data,"egwgwgrwtherthert")
                let storeDetail = data[indexPath.row]["store"] as! NSDictionary
                cell.storeName.text = storeDetail.object(forKey: "name") as! String
                cell.productType.text = storeDetail.object(forKey: "description") as! String
                if let image = storeDetail.object(forKey: "logo") as? String{
                    let url = URL(string: "http://93.188.167.68/projects/mymall_nodejs/assets/images/\(image)")
                    if url != nil{
                        cell.imageCell.af.setImage(withURL: url!)
                    }else{
                        cell.imageCell.image = UIImage(named: "c2")
                    }
                }
                
            }
            if selectedRows.contains(indexPath)
            {
                cell.likeBtn.setImage(UIImage(named: "likeInactive"), for: .normal)
            }
            else
            {
                cell.likeBtn.setImage(UIImage(named: "likeActive"), for: .normal)
            }
//            if storeData.count != 0{
//
//            }
            return cell
        }else if collectionView == browseColl{
            let cell = browseColl.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BrowseCollCell
            cell.browseCellView.layer.cornerRadius = 15
            cell.browseCellView.layer.shadowOpacity = 5
            cell.browseCellView.layer.shadowRadius = 1
            cell.browseCellView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cell.browseCellView.layer.shadowColor = UIColor.gray.cgColor
            cell.browseImageCell.layer.cornerRadius = 15
            cell.browseImageCell.layer.maskedCorners = [.layerMaxXMaxYCorner]
            
            if storeData.count != 0{
                cell.cellStoreName.text = storeData[indexPath.row]["name"] as! String
                cell.productType.text = storeData[indexPath.row]["description"] as! String
                if let image = storeData[indexPath.row]["logo"] as? String{
                    let url = URL(string: "http://93.188.167.68/projects/mymall_nodejs/assets/images/\(image)")
                    if url != nil{
                        cell.browseImageCell.af.setImage(withURL: url!)
                    }else{
                        cell.browseImageCell.image = UIImage(named: "c2")
                    }
                }
            }
           
            
            return cell
        }else{
            let cell = recentlyBrowsed.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RecentlyBrowseCell
            cell.storeName.text = recentlyData[indexPath.item]["name"] as! String
            cell.storeCategory.text = recentlyData[indexPath.item]["description"] as! String
            
            if let gallery = recentlyData[indexPath.item]["gallery"] as? [AnyObject]{
                if gallery.count != 0{
                    if let image = gallery[0]["name"] as? String{
                        let url = URL(string: "http://93.188.167.68/projects/mymall_nodejs/assets/images/\(image)")
                        if url != nil{
                            cell.storeImage.af.setImage(withURL: url!)
                        }
                        else{
                            print("vd")
                        }
                    }

                }
                            }
                
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == favouriteColl{
            if data.count == 1{
                return CGSize(width: favouriteColl.frame.width, height: favouriteColl.frame.height/1.6)
            }else{
                return CGSize(width: favouriteColl.frame.width/1.2, height: favouriteColl.frame.height/2.1)
            }
         
        }else if collectionView == browseColl{
            return CGSize(width: browseColl.frame.width/2.5, height: browseColl.frame.height)
        }else{
            return CGSize(width: browseColl.frame.width/1.3, height: browseColl.frame.height/2)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == favouriteColl{
            let vc = storyboard?.instantiateViewController(withIdentifier: "StoreVC") as! StoreVC
            let store = data[indexPath.row]["store"] as! NSDictionary
            vc.storeId = store.object(forKey: "_id") as! String
            self.navigationController?.pushViewController(vc, animated: true)
        }else if collectionView == browseColl{
            let vc = storyboard?.instantiateViewController(withIdentifier: "StoreVC") as! StoreVC
            vc.storeId = storeData[indexPath.row]["_id"] as! String
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "StoreVC") as! StoreVC
            vc.storeId = storeData[indexPath.row]["_id"] as! String
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}



class FavouriteCell: UICollectionViewCell{
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var productType: UILabel!
    override func awakeFromNib() {
        likeBtn.setImage(UIImage(named:"heartActive"), for: .normal)
    }
}
class BrowseCollCell: UICollectionViewCell{
    @IBOutlet weak var cellStoreName: UILabel!
    @IBOutlet weak var browseCellView: UIView!
    @IBOutlet weak var browseImageCell: UIImageView!
    @IBOutlet weak var productType: UILabel!
    
}

extension FavoutiteVC{
    func getFav(completion: @escaping (Bool)->()){
        if ReachabilityNetwork.isConnectedToNetwork(){
            
            let id = UserDefaults.standard.object(forKey: "id") as! String
            AF.request(Api.getFav+id,method: .get,encoding: JSONEncoding.default).responseJSON {[self]
                response in
                switch(response.result){
                    
                case .success(let json): do{
                    let success = response.response?.statusCode
                    let respond = json as! NSDictionary
                    if success == 200{
                        print(respond)
                        data = respond.object(forKey: "data") as! [AnyObject]
                        print("dgndngfn",data)
                        favouriteColl.reloadData()
                        completion(true)
                    }else{
                        completion(false)
                    }
                }
                    
                case .failure(let error): do{
                    print("error",error)
                    completion(false)
                }
                    
                }
            }
        }else{
            completion(false)
        }
    }
}
