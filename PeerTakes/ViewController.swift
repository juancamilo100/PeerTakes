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

class ViewController: UIViewController {
    
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
        playerView.loadVideoID(videoLibrary[0].videoId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

