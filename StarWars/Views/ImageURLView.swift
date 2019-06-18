//
//  ImageURLView.swift
//  StarWars
//
//  Created by Jason Barker on 6/18/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import UIKit

protocol ImageURLViewDelegate: class {
    func imageURLView(_ imageUrlView: ImageURLView, didLoad image: UIImage?, from url: URL)
    func imageURLView(_ imageUrlView: ImageURLView, failedToLoadImageWith error: Error)
}

public class ImageURLView: UIImageView {
    
    weak var delegate: ImageURLViewDelegate?
    
    public var imageUrl: URL? {
        didSet {
            image = nil
            loadURL()
        }
    }
    
    internal func loadURL() {
        guard let url = imageUrl else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                self.delegate?.imageURLView(self, failedToLoadImageWith: error)
                return
            }
            
            DispatchQueue.main.async {
                if self.imageUrl == url, let data = data {
                    self.image = UIImage(data: data)
                    self.delegate?.imageURLView(self, didLoad: self.image, from: url)
                }
            }
        }
        task.resume()
    }
}
