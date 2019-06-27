//
//  ParseDataOperation.swift
//  StarWars
//
//  Created by Jason Barker on 6/17/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import UIKit

class ParseDataOperation: BaseOperation {

    var data: Data?
    var characters: [SWCharacter]?
    
    override func main() {
        guard isCancelled == false else {
            _isFinished = true
            return
        }
        
        guard let json = data else {
            _isFinished = true
            return
        }
        
        _isExecuting = true
        
        do {
            let info = try JSONDecoder().decode(SWCharacters.self, from: json)
            characters = info.individuals
        } catch {
            delegate?.operation(operation: self, failedWith: error)
        }
        
        _isExecuting = false
        _isFinished = true
    }
}
