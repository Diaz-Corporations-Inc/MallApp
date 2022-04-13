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
    
    let player = AVPlayer()
    
    var looper : AVPlayerLooper!
    var selectedRows:[IndexPath] = []
    var storeData = [AnyObject]()
    
    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var favouriteColl: UICollectionView!
    @IBOutlet weak var mikebtn: UIButton!
    @IBOutlet weak var browseColl: UICollectionView!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var mallVideoView: UIView!
    
    var data = [AnyObject]()
    var a = ""
    var storeId = ""
    var userId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        userId = UserDefaults.standard.value(forKey: "id") as! String
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
        
        ARSLineProgress.show()
        getFav { isSuccess in
            ARSLineProgress.hide()
            if isSuccess{
                print("hello")
            }else{
                print("hii")
            }
        }
    }
    
  
    func setData(){
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
    @IBAction func mikeTapped(_ sender: Any) {
    }
    @IBAction func likeTapped(_ sender: UIButton) {[self]
       
        let store = data[sender.tag]["store"] as! NSDictionary
            storeId = store.object(forKey: "_id") as! String
    
        let favModel = favouriteModel(userId: userId, storeId: storeId)
        ApiManager.shared.favUnFav(model: favModel) { isSuccess in
            if isSuccess{
                print("success")
            }else{
                print("error")
            }
        }
        let selectedIndexPath = IndexPath(item: sender.tag, section: 0)
        if self.selectedRows.contains(selectedIndexPath)
        {
            self.selectedRows.remove(at: self.selectedRows.firstIndex(of: selectedIndexPath)!)
        }
        else
        {
            self.selectedRows.append(selectedIndexPath)
        }
        self.favouriteColl.reloadData()
    }
    
    
}

extension FavoutiteVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == favouriteColl{
            return data.count
        }else{
            return storeData.count
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
            }
            if selectedRows.contains(indexPath)
            {
                cell.likeBtn.setImage(UIImage(named: "likeActive"), for: .normal)
            }
            else
            {
                cell.likeBtn.setImage(UIImage(named: "likeInactive"), for: .normal)
            }
            return cell
        }else{
            let cell = browseColl.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BrowseCollCell
            cell.browseCellView.layer.cornerRadius = 15
            cell.browseCellView.layer.shadowOpacity = 5
            cell.browseCellView.layer.shadowRadius = 1
            cell.browseCellView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
            cell.browseCellView.layer.shadowColor = UIColor.gray.cgColor
            cell.browseImageCell.layer.cornerRadius = 15
            cell.browseImageCell.layer.maskedCorners = [.layerMaxXMaxYCorner]
            cell.cellStoreName.text = storeData[indexPath.row]["name"] as! String
            cell.productType.text = storeData[indexPath.row]["description"] as! String
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == favouriteColl{
            if data.count == 1{
                return CGSize(width: favouriteColl.frame.width/1.2, height: favouriteColl.frame.height/1.2)
            }else{
                return CGSize(width: favouriteColl.frame.width/1.2, height: favouriteColl.frame.height/2.1)
            }
         
        }else{
            return CGSize(width: browseColl.frame.width/2.5, height: browseColl.frame.height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == favouriteColl{
            let vc = storyboard?.instantiateViewController(withIdentifier: "StoreVC") as! StoreVC
            let store = data[indexPath.row]["store"] as! NSDictionary
            vc.storeId = store.object(forKey: "_id") as! String
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
