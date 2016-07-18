//
//  File.swift
//  PeerTakes
//
//  Created by Juan Espinosa on 6/20/16.
//  Copyright © 2016 JuanEspinosa. All rights reserved.
//

import Foundation

class VideoDataFetcher {
    
    let googleApiKey = "AIzaSyDwM5YGbWpME6vHZ_RYf2QuxPoXZTS0P2s"
    var googleApiRequestUrl: String!
    var jsonObject =  [String : AnyObject]()
    var viewControllerInstance: ViewController
    
    init(viewControllerInstance: ViewController) {
        
        self.viewControllerInstance = viewControllerInstance
        googleApiRequestUrl = "https://www.googleapis.com/youtube/v3/search?key=\(self.googleApiKey)" + "&channelId=UCKsvjO03BYgOaKcHNVsWz8Q&part=snippet,id&order=date&maxResults=20"
    }
    
    func getVideoData () {
        let requestUrl = NSURL(string: googleApiRequestUrl)
        let request = NSURLRequest.init(URL: requestUrl!)
        
        NSURLSession.sharedSession().dataTaskWithRequest(request) { data, _, error in
            do {
                let json = try data?.toJSON() as? [String : AnyObject]
                
                self.jsonObject = json!
                let items = self.jsonObject["items"]
                
                for var i: Int = 0; i < items?.count; i++ {
                    let video = Video()
                    if let videoId = items![i]["id"]!!["videoId"]! {
                        video.videoId = String(videoId)
                    }
                    if let videoDescription = items![i]["snippet"]!!["description"]! {
                        video.videoDescription = String(videoDescription)
                    }
                    if let videoTitle = items![i]["snippet"]!!["title"]! {
                        video.videoTitle = String(videoTitle)
                    }
                    
                    self.viewControllerInstance.videoLibrary.append(video)
                }
                
                self.viewControllerInstance.loadVideos()
            } catch {
                print("Error parsing the JSON file!")
            }
        }.resume()
    }
}