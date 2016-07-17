//
//  VideoCell.swift
//  PeerTakes
//
//  Created by Juan Espinosa on 6/20/16.
//  Copyright © 2016 JuanEspinosa. All rights reserved.
//

import Foundation
import UIKit
import YouTubePlayer
import JSON


class VideoCell: UICollectionViewCell {
    
    @IBOutlet var favoriteButton: UIButton!
    
    @IBOutlet var playerView: YouTubePlayerView!
    @IBOutlet weak var videoDescriptionLabel: UILabel!
    
    func configureLabels() {
        self.videoDescriptionLabel.layer.cornerRadius = 5
        self.videoDescriptionLabel.layer.masksToBounds = true;
    }
}
