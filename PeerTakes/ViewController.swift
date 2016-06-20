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

class ViewController: UICollectionViewController {
    
    let googleApiKey = "AIzaSyDwM5YGbWpME6vHZ_RYf2QuxPoXZTS0P2s"
    var videoLibrary = [Video]()
    
    @IBOutlet var playerView: YouTubePlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let googleApiRequestUrl = "https://www.googleapis.com/youtube/v3/search?key=\(self.googleApiKey)" + "&channelId=UCKsvjO03BYgOaKcHNVsWz8Q&part=snippet,id&order=date&maxResults=20"

        let videoDataFetcher = VideoDataFetcher(viewControllerInstance: self)
        videoDataFetcher.getVideoData(googleApiRequestUrl)
    }
    
    func loadVideo() {
        self.collectionView?.reloadData()
        print("loaded video")
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoLibrary.count
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("videoCell", forIndexPath: indexPath) as! VideoCell
        
        if(videoLibrary.count > 0) {
            cell.playerView.loadVideoID(videoLibrary[indexPath.row].videoId)
        }
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

