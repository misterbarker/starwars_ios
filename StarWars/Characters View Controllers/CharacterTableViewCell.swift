//
//  CharacterTableViewCell.swift
//  StarWars
//
//  Created by Jason Barker on 6/18/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pictureView: ImageURLView!
    @IBOutlet weak var outlineView: UIView!
    @IBOutlet weak var backgroundPictureView: ImageURLView!
    
    
    var character: StarWarsCharacter? {
        didSet {
            configureView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        outlineView.layer.masksToBounds = false
        outlineView.layer.borderColor = UIColor.white.cgColor
        outlineView.layer.borderWidth = 1
        outlineView.layer.cornerRadius = outlineView.bounds.height / 2.0
        outlineView.layer.shadowColor = UIColor.black.cgColor
        outlineView.layer.shadowOffset = CGSize(width: 0, height: 5)
        outlineView.layer.shadowOpacity = 0.45
        outlineView.layer.shadowPath = UIBezierPath(roundedRect: outlineView.bounds, cornerRadius: outlineView.layer.cornerRadius).cgPath
        outlineView.layer.shadowRadius = 3
        
        pictureView.layer.cornerRadius = pictureView.bounds.height / 2.0
        pictureView.layer.masksToBounds = true
    }

    internal func configureView() {
        nameLabel.text = character?.fullName
        
        let url = character?.profilePictureUrl
        pictureView.imageUrl = url
        backgroundPictureView.imageUrl = url
    }
}
