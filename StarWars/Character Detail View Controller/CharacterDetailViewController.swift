//
//  CharacterDetailViewController.swift
//  StarWars
//
//  Created by Jason Barker on 6/18/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var sensitivityLabel: UILabel!
    @IBOutlet weak var affiliationLabel: UILabel!
    @IBOutlet weak var affiliationImageView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    
    
    var character: StarWarsCharacter? {
        didSet {
            configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleImageSavedNotification(_:)), name: .imageSavedNotification, object: nil)
        sensitivityLabel.text = NSLocalizedString("Force Sensitive", comment: "Description of force sensitivity")
        createGradient()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }

    internal func configureView() {
        if isViewLoaded {
            if let imageName = character?.profilePictureName, let imageUrl = character?.profilePictureUrl {
                backgroundImageView.image = ImageManager.shared.getImage(name: imageName, at: imageUrl)
            } else {
                backgroundImageView.image = nil
            }
            nameLabel.text = character?.fullName
            subtitleLabel.text = character?.ageDescription
            sensitivityLabel.isHidden = !(character?.forceSensitive ?? false)
            affiliationLabel.text = character?.affiliation
            
            if let affiliation = character?.affiliation {
                affiliationImageView.image = UIImage.symbol(for: affiliation)
            } else {
                affiliationImageView.image = nil
            }
        }
    }
    
    internal func createGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.withAlphaComponent(0).cgColor, UIColor.black.cgColor]
        gradient.frame = gradientView.bounds
        gradientView.layer.addSublayer(gradient)
    }
    
    @objc
    func handleImageSavedNotification(_ notification: Notification) {
        DispatchQueue.main.async {
            if let imageName = notification.object as? String, self.character?.profilePictureName == imageName {
                self.configureView()
            }
        }
    }
}
