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
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var profileImage: UIImageView!
    var videoLibrary = [Video]()
    var favoriteVideos = [Video]()
    var favoritesManager: FavoritesManager!
    
    override func viewWillAppear(animated: Bool) {
//        favoriteVideos = favoritesManager.getFavoriteVideos(videoLibrary)
//        favoritesManager.retrieveFavorites()
        updateFavoriteVideos()
        self.collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView?.backgroundColor = UIColor(netHex:0xFF5722)
        
        updateFavoriteVideos()
    }
    
    func updateFavoriteVideos() {
        let viewController = self.tabBarController!.viewControllers![0] as! ViewController
        videoLibrary = viewController.videoLibrary
        favoriteVideos = favoritesManager.getFavoriteVideos(videoLibrary)
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteVideos.count
    }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("favoriteVideoCell", forIndexPath: indexPath) as! FavoriteVideoCell

            cell.playerView.loadVideoID(favoriteVideos[indexPath.item].videoId)
            cell.playerView.layer.cornerRadius = 5
            cell.playerView.layer.masksToBounds = true;

            if favoriteVideos[indexPath.item].videoDescription.isEmpty {
                cell.videoDescriptionLabel.text = "No description available"
            }
                
            else {
                cell.videoDescriptionLabel.text = "Description: \n\n\(favoriteVideos[indexPath.item].videoDescription)"
            }
            
            cell.configureLabels()
        
        
        return cell

    }
    
     // MARK: - UICollectionViewDelegate protocol
}