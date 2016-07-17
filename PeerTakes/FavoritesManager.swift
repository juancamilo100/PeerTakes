//
//  FavoritesManager.swift
//  PeerTakes
//
//  Created by Juan Espinosa on 7/17/16.
//  Copyright © 2016 JuanEspinosa. All rights reserved.
//

import Foundation

class FavoritesManager {
    var favoriteVideos = [String]()
    let favoriteVideosUserDefaultKey = "favoriteVideos"
    
    func saveFavorite(videoId: String) {
        favoriteVideos.append(videoId)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(favoriteVideos, forKey: favoriteVideosUserDefaultKey)
    }
    
    func removeFavorite(videoId: String) {
        if let index = favoriteVideos.indexOf(videoId) {
            favoriteVideos.removeAtIndex(index)
        }
        else {
            print("Couldn't find favorite")
        }
    }
    
    func isFavorite(videoId: String) -> Bool {
        return favoriteVideos.contains(videoId)
    }
    
    func retrieveFavorites() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let favoriteVideosBuffer = defaults.stringArrayForKey(favoriteVideosUserDefaultKey) {
                favoriteVideos += favoriteVideosBuffer
        }
    }
}