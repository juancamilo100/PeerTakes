//
//  FavoritesViewController.swift
//  PeerTakes
//
//  Created by Juan Espinosa on 7/17/16.
//  Copyright © 2016 JuanEspinosa. All rights reserved.
//

import Foundation
import UIKit

class FavoritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var profileImage: UIImageView!
    var videoLibrary = [Video]()
    var favoriteVideos = [Video]()
    var favoritesManager: FavoritesManager!
    
    override func viewWillAppear(animated: Bool) {
        updateFavoriteVideos()
        self.collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
   
        self.view.backgroundColor = UIColor(netHex:0xFFB74D)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView?.backgroundColor = UIColor(netHex:0xFFB74D)
        
        retrieveProfilePic()
        formatProfilePicture()
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
    
    func formatProfilePicture() {
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        self.profileImage.clipsToBounds = true;
        self.profileImage.layer.borderWidth = 3
        self.profileImage.layer.borderColor = UIColor.whiteColor().CGColor;
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("profileImageTapped:"))
        self.profileImage.userInteractionEnabled = true
        self.profileImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func profileImageTapped(img: AnyObject)
    {
        print("Image tapped")
        
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            imagePicker.sourceType = .Camera
        }
        else {
            imagePicker.sourceType = .PhotoLibrary
        }
        imagePicker.delegate = self
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let tempImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageData: NSData = UIImagePNGRepresentation(tempImage)!
        saveProfilePicture(imageData)
        let pngImage = UIImage(data:imageData,scale:1.0)
        
        self.profileImage.image = pngImage
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveProfilePicture(imageData: NSData) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(imageData, forKey: "profilePic")
    }
    
    func retrieveProfilePic() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let imageData = defaults.dataForKey("profilePic") {
            self.profileImage.image = UIImage(data: imageData)
        }
        else {
            self.profileImage.image = UIImage(named: "profilePlaceHolder.jpg")
        }
    }
}