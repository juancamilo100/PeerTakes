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
    
    @IBOutlet var playerView: YouTubePlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let myVideoURL = NSURL(string: "https://www.youtube.com/watch?v=WMUlhi_v4co")
//        playerView.loadVideoURL(myVideoURL!)
        

        
        playerView.loadPlaylistID("UUKsvjO03BYgOaKcHNVsWz8Q")

        let url = NSURL(string: "https://www.googleapis.com/youtube/v3/search?key=AIzaSyDwM5YGbWpME6vHZ_RYf2QuxPoXZTS0P2s&channelId=UCKsvjO03BYgOaKcHNVsWz8Q&part=snippet,id&order=date&maxResults=20")
        let request = NSURLRequest.init(URL: url!)
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { data, _, error in
            do {
                let JSON = try data?.toJSON() as? [String : AnyObject]
                var videosArray: [AnyObject?] = []
                var items = JSON!["items"]
                for var i: Int = 0; i < items?.count; i++ {
                    let videoId = JSON!["items"]![i]["id"]!!["videoId"]
                    videosArray.append(videoId)
                    
                }
//                var videoId = JSON!["items"]![0]["id"]!!["videoId"]
                
                print(videosArray)
            } catch {
                // Handle error
            }
            }.resume()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

