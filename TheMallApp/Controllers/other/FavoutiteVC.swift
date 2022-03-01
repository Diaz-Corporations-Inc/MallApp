//
//  FavoutiteVC.swift
//  TheMallApp
//
//  Created by mac on 11/02/2022.
//

import UIKit
import AVKit
class FavoutiteVC: UIViewController {

    
    
    let player = AVPlayer()

      
    
    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var favouriteColl: UICollectionView!
    @IBOutlet weak var mikebtn: UIButton!
    @IBOutlet weak var browseColl: UICollectionView!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var mallVideoView: UIView!
    
    var a = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
        mallVideoView.backgroundColor = UIColor.clear
        if a == ""{
            backbtn.isHidden = true
        }else{
            backbtn.isHidden = false
        }
    }
    
    private func playVideo() {
            guard let path = Bundle.main.path(forResource: "abc", ofType:"mov") else {
                debugPrint("video.m4v not found")
                return
            }
            let player = AVPlayer(url: URL(fileURLWithPath: path))
           let playerLayer = AVPlayerLayer(player: player)
        mallVideoView.clipsToBounds = true
        playerLayer.frame = self.mallVideoView.bounds
            self.mallVideoView.layer.addSublayer(playerLayer)
                player.play()
            
        }

    @IBAction func browseAll(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "BrowseAllVC") as! BrowseAllVC
        vc.a = "1"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func backTApped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func mikeTapped(_ sender: Any) {
    }
    @IBAction func likeTapped(_ sender: Any) {
    }
    
}

extension FavoutiteVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == favouriteColl{
            let cell = favouriteColl.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FavouriteCell
            cell.cellView.layer.cornerRadius = 20
            cell.cellView.layer.shadowColor = UIColor.gray.cgColor
            cell.cellView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            cell.cellView.layer.shadowRadius = 1
            cell.cellView.layer.shadowOpacity = 5
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
         return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == favouriteColl{
            return CGSize(width: favouriteColl.frame.width/1.2, height: favouriteColl.frame.height/2.1)
        }else{
            return CGSize(width: browseColl.frame.width/2.5, height: browseColl.frame.height)
        }
        
    }
    
    
}



class FavouriteCell: UICollectionViewCell{
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var apartMent: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var productType: UILabel!
    override func awakeFromNib() {
        
    }
}
class BrowseCollCell: UICollectionViewCell{
    @IBOutlet weak var cellStoreName: UILabel!
    @IBOutlet weak var browseCellView: UIView!
    @IBOutlet weak var browseImageCell: UIImageView!
    @IBOutlet weak var productType: UILabel!
    
}
