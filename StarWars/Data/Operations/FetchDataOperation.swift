//
//  FetchDataOperation.swift
//  StarWars
//
//  Created by Jason Barker on 6/15/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import Foundation

class FetchDataOperation: BaseOperation {
    
    let serviceUrl = URL(string: "https://edge.ldscdn.org/mobile/interview/directory")!
    
    var data: Data?
    var urlSession: URLSession
    
    init(session: URLSession = URLSession.shared) {
        urlSession = session
    }
    
    override func main() {
        guard isCancelled == false else {
            _isFinished = true
            return
        }
        
        _isExecuting = true
        
        let task = urlSession.dataTask(with: serviceUrl) { (data, response, error) in
            defer {
                self._isExecuting = false
                self._isFinished = true
            }
            
            guard self.isCancelled == false else { return }
            
            if let error = error {
                self.delegate?.operation(operation: self, failedWith: error)
                return
            }
            
            self.data = data
        }
        task.resume()
    }

}
