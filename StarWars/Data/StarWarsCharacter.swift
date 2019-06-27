//
//  StarWarsCharacter.swift
//  StarWars
//
//  Created by Jason Barker on 6/27/19.
//  Copyright © 2019 Jason Barker. All rights reserved.
//

import CoreData

extension StarWarsCharacter {
    
    var fullName: String {
        get {
            switch (firstName, lastName) {
            case let (.some(firstName), .some(lastName)):
                return "\(firstName) \(lastName)"
            case let (.some(firstName), nil):
                return "\(firstName)"
            case let (nil, .some(lastName)):
                return "\(lastName)"
            default:
                return ""
            }
        }
    }
    
    var ageDescription: String? {
        if let date = birthdate {
            let years = Calendar.current.dateComponents([.year], from: date, to: Date()).year
            return "\(years ?? 0) years old"
        }
        return nil
    }
}
