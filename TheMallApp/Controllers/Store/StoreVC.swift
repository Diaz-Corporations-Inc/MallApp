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

import AlamofireImage
class StoreVC: UIViewController {

    @IBOutlet weak var visitStore: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var storeCollection: UICollectionView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var companyImge: UIImageView!
    @IBOutlet weak var storeImage: UIImageView!
    @IBOutlet weak var storeTiming: UILabel!
    @IBOutlet weak var storeLocation: UILabel!
    @IBOutlet weak var contact: UILabel!
    @IBOutlet weak var priceRange: UILabel!
    @IBOutlet weak var mallVideoView: UIView!
    @IBOutlet weak var at_aGlance_lbl: UILabel!
    var key = ""
    var storeId = ""
    var storeData : NSDictionary!
    var gallery = [AnyObject]()
    let player = AVPlayer()

    var looper : AVPlayerLooper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
        storeImage.isHidden = true
        setData()

    }
    
    func setData(){
        ARSLineProgress.show()
        ApiManager.shared.storeById(storeid: storeId) { [self] isSuccess in
            ARSLineProgress.hide()
            if isSuccess{
                storeData = ApiManager.shared.dataDict
             let priceRangedict = storeData.object(forKey: "priceRange") as! NSDictionary
                priceRange.text = "\(priceRangedict.object(forKey: "from") as? Int ?? 0) - \(priceRangedict.object(forKey: "to") as? Int ?? 0) $"
                contact.text = ""
                storeLocation.text = ""
                gallery = storeData.object(forKey: "gallery") as! [AnyObject]
                
                if let logoImage = storeData.object(forKey: "logo") as? String{
                    DispatchQueue.main.async {
                        let url = URL(string: logoImage)
                        print(url)
                        if url != nil{
                            storeImage.af.setImage(withURL: url!)
                        }else{
                            print("hello")
                        }
                    }
                }
            }else{
                print("something went wrong")
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

    @IBAction func editBtn(_ sender: Any) {
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
    
    @IBAction func visitWebsite(_ sender: Any) {
        
    }
    
}

extension StoreVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let storetype = UserDefaults.standard.value(forKey: "storetype") as? String else { return 10 }
        if storetype == "store"{
            self.at_aGlance_lbl.isHidden = true
            return gallery.count
        }else{
            return gallery.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = storeCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! StoreCell
        
//        if  let galleryImage = gallery[indexPath.row]["name"] as? String{
//            DispatchQueue.main.async {
//                let url = URL(string: galleryImage)
//                if url != nil{
//                    cell.cellImage.af.setImage(withURL: url!)
//                }else{
//                    print("hello")
//                }
//            }
//        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: storeCollection.frame.width/3, height: storeCollection.frame.height/3)
    }
    
    
    
}

class StoreCell: UICollectionViewCell{
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cellImage: UIImageView!
}
