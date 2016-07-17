//
//  FavoritesViewController.swift
//  PeerTakes
//
//  Created by Juan Espinosa on 7/17/16.
//  Copyright © 2016 JuanEspinosa. All rights reserved.
//

import Foundation
import UIKit

class FavoritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var profileImage: UIImageView!
    var videoLibrary = [Video]()
    
    override func viewDidLoad() {
       let viewController = self.tabBarController!.viewControllers![0] as! ViewController
       videoLibrary = viewController.videoLibrary
    }
    
    var favoritesManager: FavoritesManager!
    
    // MARK: - UICollectionViewDataSource protocol
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesManager.getNumberOfFavorites()
    }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("favoriteVideoCell", forIndexPath: indexPath) as! VideoCell
        
        if videoLibrary.count > 0 && favoritesManager.isFavorite(videoLibrary[indexPath.row].videoId) {
            cell.playerView.loadVideoID(videoLibrary[indexPath.row].videoId)
            cell.playerView.layer.cornerRadius = 5
            cell.playerView.layer.masksToBounds = true;
            
            cell.favoriteButton?.layer.setValue(indexPath.row, forKey: "index")
            cell.favoriteButton?.layer.cornerRadius = 10
            cell.favoriteButton?.addTarget(self, action: "favoriteButtonAction:", forControlEvents: UIControlEvents.TouchUpInside)

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
    
     // MARK: - UICollectionViewDelegate protocol
}