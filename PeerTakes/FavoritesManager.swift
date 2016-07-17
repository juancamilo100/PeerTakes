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
    
    func saveFavorites() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(favoriteVideos, forKey: favoriteVideosUserDefaultKey)
    }
    
    func addFavorite(videoId: String) {
        favoriteVideos.append(videoId)
        saveFavorites()
    }
    
    func removeFavorite(videoId: String) {
        if let index = favoriteVideos.indexOf(videoId) {
            favoriteVideos.removeAtIndex(index)
            saveFavorites()
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
    
    func getNumberOfFavorites() -> Int {
        return favoriteVideos.count
    }
}