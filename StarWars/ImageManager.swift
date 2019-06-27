//
//  ImageManager.swift
//  StarWars
//
//  Created by Jason Barker on 6/27/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import UIKit

class ImageManager {

    static let shared = ImageManager()
    
    internal var imagesInProgress: [String] = []
    
    private init() {
    }
    
    func getImage(name: String, at url: URL) -> UIImage? {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let imageFile = documentDirectory.appendingPathComponent(name)
            if let image = UIImage(contentsOfFile: imageFile.path) {
                return image
            }
        }
        
        objc_sync_enter(imagesInProgress)
        if !imagesInProgress.contains(name) {
            imagesInProgress.append(name)
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                objc_sync_enter(self.imagesInProgress)
                if let index = self.imagesInProgress.firstIndex(of: name) {
                    self.imagesInProgress.remove(at: index)
                }
                objc_sync_exit(self.imagesInProgress)
                
                if let data = data, error == nil {
                    if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                        let imageFile = documentDirectory.appendingPathComponent(name)
                        try? data.write(to: imageFile)
                        NotificationCenter.default.post(name: .imageSavedNotification, object: name)
                    }
                }
                }.resume()
        }
        objc_sync_exit(imagesInProgress)

        return nil
    }
}

extension Notification.Name {
    static let imageSavedNotification = Notification.Name("imageSavedNotification")
}
