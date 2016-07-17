//
//  ViewController.swift
//  PeerTakes
//
//  Created by Juan Espinosa on 6/12/16.
//  Copyright © 2016 JuanEspinosa. All rights reserved.
//

import UIKit
import YouTubePlayer
import JSON

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    

    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

class ViewController: UICollectionViewController {
    

    let googleApiKey = "AIzaSyDwM5YGbWpME6vHZ_RYf2QuxPoXZTS0P2s"
    var videoLibrary = [Video]()
    var favoriteVideos = [Video]()
    var favoritesManager: FavoritesManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let googleApiRequestUrl = "https://www.googleapis.com/youtube/v3/search?key=\(self.googleApiKey)" + "&channelId=UCKsvjO03BYgOaKcHNVsWz8Q&part=snippet,id&order=date&maxResults=20"

        let videoDataFetcher = VideoDataFetcher(viewControllerInstance: self)
        videoDataFetcher.getVideoData(googleApiRequestUrl)
        
        self.collectionView?.backgroundColor = UIColor(netHex:0xFF5722)
    }
    
    func loadVideos() {
        self.collectionView?.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoLibrary.count
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func favoriteButtonAction(sender:UIButton) {
        let buttonIndex: Int = (sender.layer.valueForKey("index")) as! Int
        let videoId = videoLibrary[buttonIndex].videoId
        
        if favoritesManager.isFavorite(videoId) {
            favoritesManager.removeFavorite(videoId)
            print("Removed favorite")
        }
        else {
            favoritesManager.addFavorite(videoId)
            print("Saved favorite")
        }
        loadVideos()
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("videoCell", forIndexPath: indexPath) as! VideoCell
        
        if videoLibrary.count > 0 {
            cell.playerView.loadVideoID(videoLibrary[indexPath.row].videoId)
            cell.playerView.layer.cornerRadius = 5
            cell.playerView.layer.masksToBounds = true;
            
            cell.favoriteButton?.layer.setValue(indexPath.row, forKey: "index")
            cell.favoriteButton?.layer.cornerRadius = 10
            cell.favoriteButton?.addTarget(self, action: "favoriteButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)
            
            if favoritesManager.isFavorite(videoLibrary[indexPath.row].videoId) {
                cell.favoriteButton?.setImage(UIImage(named: "favorite.png"), forState: UIControlState.Normal)
            }
            else {
                cell.favoriteButton?.setImage(UIImage(named: "unfavorite.png"), forState: UIControlState.Normal)
            }
            
            if videoLibrary[indexPath.row].videoDescription.isEmpty {
                cell.videoDescriptionLabel.text = "No description available"
            }
            
            else {
            cell.videoDescriptionLabel.text = "Description: \n\n\(videoLibrary[indexPath.row].videoDescription)"
            }
            
            cell.configureLabels()
        }
        
        return cell
    }
    
    //For the header
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "videoCollectionHeader",
                forIndexPath: indexPath) as! VideoCollectionHeaderView
            
            headerView.headerLabel.text = "Latest Videos"
            return headerView
            
        default:
            assert(false, "Unexpected element kind")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

